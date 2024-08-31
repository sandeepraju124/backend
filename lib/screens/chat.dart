import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../provider/chat_provider.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatelessWidget {
  final String userId;

  ChatListScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations',
          // style: TextStyle(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          if (provider.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No conversations yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: provider.conversations.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final conversation = provider.conversations[index];
              String? otherParticipantId = (conversation['participants'] as List<dynamic>)
                  .firstWhere((id) => id != userId, orElse: () => null);

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    otherParticipantId?.substring(0, 1).toUpperCase() ?? '?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  otherParticipantId ?? 'Unknown',
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  conversation['last_message'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  '2d',
                  // DateFormat('MMM d').format(DateTime.parse(conversation['updated_at'])),
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        businessId: otherParticipantId!,
                        userId: userId,
                        conversationId: conversation['conversation_id'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String userId;
  final String businessId;
  final String conversationId;

  ChatScreen({
    required this.userId,
    required this.businessId,
    this.conversationId = 'nI63HUrLNBQk77aEHY',
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;
  bool _prefsInitialized = false;
  int _page = 1;
  final int _pageSize = 20;
  late SharedPreferences _prefs;
  bool _isNewConversation = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _initSocket();
  }

  // ... [Keep the existing methods for _initSharedPreferences, _initSocket, _loadMessages, _fetchNewMessages, _saveMessagesToLocalStorage, _handleIncomingMessage, _sendMessageHttp, and _sendMessage]
  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsInitialized = true;
    });
    _loadMessages();
  }

  void _initSocket() {
    socket = IO.io('http://10.0.2.2:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on('connect', (_) => print('Connected to server'));
    socket.on('disconnect', (_) => print('Disconnected from server'));
    socket.on('message', _handleIncomingMessage);

    socket.emit('join', {'username': widget.userId, 'room': widget.conversationId});
  }

  void _loadMessages() async {
    if (!_prefsInitialized) return;

    setState(() {
      _isLoading = true;
    });

    // Load messages from local storage
    String? storedMessages = _prefs.getString('messages_${widget.conversationId}');
    if (storedMessages != null) {
      setState(() {
        _messages = List<Map<String, dynamic>>.from(json.decode(storedMessages));
      });
    }

    // Fetch new messages from the server
    await _fetchNewMessages();

    setState(() {
      _isLoading = false;
      _isNewConversation = _messages.isEmpty;
    });
  }

  Future<void> _fetchNewMessages() async {
    String lastMessageTimestamp = _messages.isNotEmpty ? _messages.first['timestamp'] : '0';
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/conversations/${widget.conversationId}/messages?since=$lastMessageTimestamp'),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> newMessages = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        _messages = [...newMessages, ..._messages];
        _isNewConversation = _messages.isEmpty;
      });
      _saveMessagesToLocalStorage();
    } else if (response.statusCode == 404) {
      setState(() {
        _isNewConversation = true;
      });
    }
  }

  void _saveMessagesToLocalStorage() {
    _prefs.setString('messages_${widget.conversationId}', json.encode(_messages));
  }

  void _handleIncomingMessage(dynamic data) {
    setState(() {
      if (!_messages.any((msg) => msg['message_id'] == data['message_id'])) {
        _messages.insert(0, Map<String, dynamic>.from(data));
        _isNewConversation = false;
        _saveMessagesToLocalStorage();
      }
    });
  }



  Future<Map<String, dynamic>?> _sendMessageHttp(String message) async {
    final url = Uri.parse('http://10.0.2.2:5000/api/messages');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'sender_id': widget.userId,
        // 'recipient_id': widget.recipientId,
        // 'recipient_id': 'BUSINESS123',
        'recipient_id': widget.businessId,
        'message': message,
        // 'conversation_id': '${widget.userId}BUSINESS123',
        'conversation_id': widget.conversationId,
        // widget.conversationId,
      }),
    );

    if (response.statusCode == 201) {
      print('Message sent and saved to database');
      return json.decode(response.body);

    } else {
      print('Failed to send message: ${response.body}');
      return null;
    }
  }


  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final message = _messageController.text;
      final sentMessage = await _sendMessageHttp(message);
      // var chatProvider = Provider.of<ChatProvider>(context, listen: false);
      // final sentMessage = chatProvider.sendMessageHttp(message, widget.userId, widget.businessId, widget.conversationId);

      if (sentMessage != null) {
        setState(() {
          _messages.insert(0, sentMessage);
          _isNewConversation = false;
        });
        _saveMessagesToLocalStorage();
        _messageController.clear();
      } else {
        // Fallback to socket if HTTP fails
        socket.emit('message', {
          'sender_id': widget.userId,
          'message': message,
          'conversation_id': widget.conversationId,
        });
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message sent via fallback method. It may take longer to appear.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_prefsInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Chat')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        var chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.refreshConversations(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.businessId,
            // style: TextStyle(fontWeight: FontWeight.bold)
          ),
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _isNewConversation
                  ? _buildNewConversationPrompt()
                  : _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewConversationPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Start a new conversation',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: _messages.length + 1,
      itemBuilder: (context, index) {
        if (index == _messages.length) {
          return _buildLoadMoreButton();
        }
        return _buildMessageBubble(_messages[index]);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final bool isMe = message['sender_id'] == widget.userId;
    final backgroundColor = isMe ? Colors.teal.shade100 : Colors.grey.shade200;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['message'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('MMM d, HH:mm').format(DateTime.parse(message['timestamp'])),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return TextButton(
      onPressed: _loadMoreMessages,
      child: Text('Load More'),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.teal),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

// ... [Keep the existing _loadMoreMessages method]
  void _loadMoreMessages() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/conversations/${widget.conversationId}/messages?page=$_page&pageSize=$_pageSize'),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> newMessages = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        // Filter out messages that are already in the list
        newMessages = newMessages.where((newMsg) {
          return !_messages.any((existingMsg) => existingMsg['message_id'] == newMsg['message_id']);
        }).toList();

        _messages.addAll(newMessages);
        _page++;
      });
      _saveMessagesToLocalStorage();
    }

    setState(() {
      _isLoading = false;
    });
  }
}