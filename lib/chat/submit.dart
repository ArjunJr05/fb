// ignore_for_file: unused_element, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:fb/chat/chat_msg.dart';
import 'package:fb/chat/palm.dart';

void _submitMessage(String message) async {
  if (message.isEmpty) {
    return;
  }
  setState(() {
    var _messages;
    _messages.insert(
      0,
      ChatMessage(message: message, fromUser: true),
    );
  });

  var _controller;
  _controller.clear();

  final response = await PalmService.instance.generateMessage(message);
  setState(() {
    var _messages;
    _messages.insert(
      0,
      ChatMessage(
        message: response ?? "An error occurred, please try again",
        fromUser: false,
      ),
    );
  });
}

void setState(Null Function() param0) {}
