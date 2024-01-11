// ignore_for_file: override_on_non_overriding_member, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, dead_code, body_might_complete_normally_nullable, non_constant_identifier_names, unused_import, prefer_const_constructors, use_super_parameters

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.message,
    required this.fromUser,
  }) : super(key: key);

  final String message;
  final bool fromUser;

  get apiKey => null;

  @override
  Future<String?> generateMessage(String prompt) async {
    var http;
    final result = await http.post(
        Uri.parse(
            "https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=${apiKey}"),
        body: jsonEncode({
          "prompt": {"text": prompt},
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"});
    if (result.statusCode == 200) {
      return (jsonDecode(result.body)["candidates"] as List<dynamic>)
          .firstOrNull?["output"];
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Determine the profile image based on the sender
    Widget profileImage = fromUser
        ? CircleAvatar(
            backgroundImage: AssetImage('images/dp.png'),
            radius: 25,
          )
        : CircleAvatar(
            backgroundImage: AssetImage('images/chatbot.jpg'),
            radius: 25,
          );

    return Column(
      crossAxisAlignment:
          fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Circular profile image
        profileImage,
        Align(
          alignment: fromUser
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            margin: EdgeInsetsDirectional.only(
              top: 8.0,
              bottom: 8.0,
              start: fromUser ? 80.0 : 16.0,
              end: fromUser ? 16.0 : 80.0,
            ),
            decoration: BoxDecoration(
              color: fromUser
                  ? Color.fromARGB(255, 252, 204, 15)
                  : Color.fromARGB(255, 62, 171, 181),
              borderRadius: BorderRadiusDirectional.only(
                topStart: const Radius.circular(16.0),
                topEnd: const Radius.circular(16.0),
                bottomStart: Radius.circular(fromUser ? 16.0 : 0.0),
                bottomEnd: Radius.circular(fromUser ? 0.0 : 16.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fromUser ? "Me" : "Learn Hub",
                  style: textTheme.titleMedium?.apply(
                    color: fromUser
                        ? colorScheme.onPrimaryContainer
                        : Colors.white,
                  ),
                ),
                Text(
                  message,
                  style: textTheme.bodySmall?.apply(
                    color: fromUser
                        ? colorScheme.onPrimaryContainer
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
