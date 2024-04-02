import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';


class MyAppp extends StatelessWidget {
  // final WebSocketChannel channel = IOWebSocketChannel.connect('ws://127.0.0.1:5000/');
  // final WebSocketChannel channel = IOWebSocketChannel.connect('wss://10.0.2.2:5000/');
  final WebSocketChannel channel = IOWebSocketChannel.connect('wss://192.168.1.10:5000/');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Demo'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            channel.sink.add('Hello, WebSocket Server!');
          },
          child: Icon(Icons.send),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    // super.dispose();
  }
}
