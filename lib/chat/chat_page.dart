// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_import, avoid_unnecessary_containers, unused_field, unused_element, empty_statements, unused_label, dead_code, use_super_parameters

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fb/chat/chat_msg.dart';
import 'package:fb/chat/palm.dart';
import 'package:fb/features/user_auth/presentation/pages/home_page.dart';
import 'package:fb/features/user_auth/presentation/pages/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final _controller = TextEditingController()
    ..addListener(
      () => setState(() {}),
    );

  final _messages = <ChatMessage>[];
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/healt.jpg"))),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
              children: [
                if (_submitting)
                  Center(child: const CircularProgressIndicator()),
                ..._messages,
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Card(
                  margin:
                      EdgeInsets.only(left: 0, right: 0, bottom: 15, top: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Type your question!...",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                )),
                            controller: _controller,
                            onSubmitted: _submitMessage,
                            enabled: !_submitting,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _controller.text.isEmpty || _submitting
                            ? null
                            : () {
                                _submitMessage(_controller.text);
                              },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ))),
        ],
      ),
    ));
  }

  void _submitMessage(String message) async {
    if (message.isEmpty) {
      return;
    }
    setState(() {
      _submitting = true;
      _messages.insert(
        0,
        ChatMessage(message: message, fromUser: true),
      );
    });

    _controller.clear();

    final response = await PalmService.instance.generateMessage(message);
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          message: response ?? "An error occurred, please try again",
          fromUser: false,
        ),
      );
      _submitting = false;
    });
  }
}
