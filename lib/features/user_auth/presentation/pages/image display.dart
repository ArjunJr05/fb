// ignore_for_file: prefer_const_constructors, file_names, unused_element

import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplayPage extends StatelessWidget {
  final File selectedImage;

  const ImageDisplayPage({Key? key, required this.selectedImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Image.file(
          selectedImage,
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Padding(
          padding: EdgeInsets.only(left: 70),
          child: SafeArea(
            child: Text(
              'Health Lens',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
