import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constants.dart';

// class ChatProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _conversations = [];
//
//   List<Map<String, dynamic>> get conversations => _conversations;
//
//   Future<void> fetchConversations(String businessId) async {
//     final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/conversationslist/$businessId'));
//
//     if (response.statusCode == 200) {
//       _conversations = List<Map<String, dynamic>>.from(json.decode(response.body));
//       print(_conversations);
//       notifyListeners();
//     } else if (response.statusCode == 404) {
//       _conversations = [];
//       notifyListeners();
//       print('No conversations found, empty list');
//     } else {
//       print('Failed to load conversations');
//     }
//   }
//
//   String getConversationId(String userId, String businessId) {
//     for (var conversation in _conversations) {
//       if (conversation['participants'].contains(businessId)) {
//         return conversation['conversation_id'];
//       }
//     }
//     // If businessId is not found, create a new conversationId
//     return '$userId$businessId';
//   }
//
//   // void refreshConversations() {
//   //   // Logic to refresh the conversation list
//   //   notifyListeners();
//   // }
//   Future<void> refreshConversations(BuildContext context) async {
//     String businessUid = await getBusinessUid(context);
//     await fetchConversations(businessUid);
//     // await fetchConversations("BIZPLUaYVJg3dqD9");
//   }
//
//
//   Future<Map<String, dynamic>?> sendMessageHttp(String message, String businessId, String userId, String conversationId) async {
//     final url = Uri.parse('http://10.0.2.2:5000/api/messages');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'sender_id': userId,
//         // 'recipient_id': widget.recipientId,
//         // 'recipient_id': 'BUSINESS123',
//         'recipient_id': businessId,
//         'message': message,
//         // 'conversation_id': 'nI63HUrLNBQk77aEHY',
//         'conversation_id': conversationId,
//         // widget.conversationId,
//       }),
//     );
//
//     if (response.statusCode == 201) {
//       print('Message sent and saved to database');
//       return json.decode(response.body);
//     } else {
//       print('Failed to send message: ${response.body}');
//       return null;
//     }
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatProvider with ChangeNotifier {
  List<Map<String, dynamic>> _conversations = [];
  WebSocketChannel? _channel;

  List<Map<String, dynamic>> get conversations => _conversations;

  void _initializeWebSocket(String conversationId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:5000/socket.io/?EIO=4&transport=websocket'),
    );

    _channel!.sink.add(json.encode({
      'event': 'join',
      'data': {'room': conversationId}
    }));

    _channel!.stream.listen((data) {
      final message = json.decode(data);
      if (message['event'] == 'message') {
        _handleIncomingMessage(message['data']);
      }
    });
  }

  void _handleIncomingMessage(Map<String, dynamic> message) {
    final conversationId = message['conversation_id'];
    final index = _conversations.indexWhere((conv) => conv['conversation_id'] == conversationId);

    if (index != -1) {
      _conversations[index]['messages'].insert(0, message);
      notifyListeners();
    }
  }

  Future<void> fetchConversations(String businessId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/conversationslist/$businessId'));

    if (response.statusCode == 200) {
      _conversations = List<Map<String, dynamic>>.from(json.decode(response.body));
      _initializeWebSocket(_conversations.first['conversation_id']);
      notifyListeners();
    } else if (response.statusCode == 404) {
      _conversations = [];
      notifyListeners();
    } else {
      print('Failed to load conversations');
    }
  }

  Future<Map<String, dynamic>?> sendMessageHttp(String message, String businessId, String userId, String conversationId) async {
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
      _channel?.sink.add(json.encode({
        'event': 'message',
        'data': sentMessage
      }));
      return sentMessage;
    } else {
      print('Failed to send message: ${response.body}');
      return null;
    }
  }

  @override
  void dispose() {
    _channel?.sink.close(status.goingAway);
    super.dispose();
  }
}
