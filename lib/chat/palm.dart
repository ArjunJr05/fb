// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PalmService {
  PalmService._(this.apiKey);
  final String apiKey;

  static PalmService? _instance;

  static init(String apiKey) {
    if (_instance != null) {
      throw FlutterError("Already inited!");
    }
    _instance = PalmService._(apiKey);
  }

  static PalmService get instance {
    if (_instance != null) {
      return _instance!;
    }
    throw StateError(
      "Palm services must be inited! call PalmService.init(String apiKey) before use",
    );
  }

  Future<String?> generateMessage(String prompt) async {
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
    }
    if (kDebugMode) {
      print(result.body);
    }
    return null;
  }
}
