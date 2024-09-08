import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatProvider with ChangeNotifier {
  List<Map<String, dynamic>> _conversations = [];
  IO.Socket? _socket;
  String? _currentUserId;

  List<Map<String, dynamic>> get conversations => _conversations;

  void initializeSocket(String userId) {
    _currentUserId = userId;
    _socket = IO.io('http://10.0.2.2:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();
    _socket!.on('connect', (_) {
      print('Connected to WebSocket');
      _socket!.emit('join_chat_list', {'user_id': userId});
    });

    _socket!.on('chat_list_update', (data) {
      _conversations = List<Map<String, dynamic>>.from(data);
      notifyListeners();
    });

    _socket!.on('message', (data) {
      _handleIncomingMessage(data);
    });
  }

  void _handleIncomingMessage(Map<String, dynamic> message) {
    final conversationId = message['conversation_id'];
    final index = _conversations.indexWhere((conv) => conv['conversation_id'] == conversationId);

    if (index != -1) {
      _conversations[index]['last_message'] = message['message'];
      _conversations[index]['updated_at'] = message['timestamp'];
      _conversations.sort((a, b) => b['updated_at'].compareTo(a['updated_at']));
    } else {
      // If the conversation doesn't exist, add it
      _conversations.add({
        'conversation_id': conversationId,
        'participants': [_currentUserId, message['sender_id']],
        'last_message': message['message'],
        'updated_at': message['timestamp'],
      });
    }
    notifyListeners();
  }

  Future<void> fetchConversations(String userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/conversationslist/$userId'));

    if (response.statusCode == 200) {
      _conversations = List<Map<String, dynamic>>.from(json.decode(response.body));
      notifyListeners();
    } else if (response.statusCode == 404) {
      _conversations = [];
      notifyListeners();
    } else {
      print('Failed to load conversations');
    }
  }

  String getConversationId(String userId, String businessId) {
    for (var conversation in _conversations) {
      if (conversation['participants'].contains(businessId)) {
        return conversation['conversation_id'];
      }
    }
    return '$userId$businessId';
  }

  Future<void> refreshConversations(BuildContext context) async {
    String businessUid = await getBusinessUid(context);
    await fetchConversations(businessUid);
  }

  void joinConversation(String conversationId) {
    _socket?.emit('join', {'username': _currentUserId, 'room': conversationId});
  }

  void leaveConversation(String conversationId) {
    _socket?.emit('leave', {'username': _currentUserId, 'room': conversationId});
  }

  Future<Map<String, dynamic>?> sendMessage(String message, String businessId, String userId, String conversationId) async {
    final url = Uri.parse('http://10.0.2.2:5000/api/messages');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'sender_id': userId,
        'recipient_id': businessId,
        'message': message,
        'conversation_id': conversationId,
      }),
    );

    if (response.statusCode == 201) {
      final sentMessage = json.decode(response.body);
      // Update the local conversation list immediately
      _handleIncomingMessage(sentMessage);
      return sentMessage;
    } else {
      print('Failed to send message: ${response.body}');
      return null;
    }
  }

  @override
  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();
  }
}

