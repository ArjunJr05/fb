// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TransportModel {
  late String name;
  late String iconPath;
  late String difficulty;
  late String duration;
  late String mode;
  late Color boxColor;
//  late GestureDetector gestureDetector;
  late bool viewIsSelected;
  TransportModel({
    required this.name,
    required this.iconPath,
    required this.difficulty,
    required this.duration,
    required this.mode,
    required this.boxColor,
    // required this.gestureDetector,
    required this.viewIsSelected,
  });
  static List<TransportModel> getTransport() {
    List<TransportModel> transport = [];

    transport.add(TransportModel(
        name: 'FDS',
        iconPath: 'images/data.png',
        difficulty: 'Medium',
        duration: '30 minutes',
        mode: 'Multiple choice',
        viewIsSelected: true,
        boxColor: Colors.deepPurpleAccent));

    transport.add(TransportModel(
      name: 'DSD',
      iconPath: 'images/design.png',
      difficulty: 'Low',
      duration: '30 minutes',
      mode: 'Multiple choice',
      viewIsSelected: true,
      boxColor: Colors.deepPurpleAccent,
    ));
    transport.add(TransportModel(
      name: 'PC',
      iconPath: 'images/c.png',
      difficulty: 'Low',
      duration: '30 minutes',
      mode: 'Multiple choice',
      viewIsSelected: true,
      boxColor: Colors.deepPurpleAccent,
    ));
    transport.add(TransportModel(
      name: 'MATHS',
      iconPath: 'images/system.png',
      difficulty: 'Hard',
      duration: '30 minutes',
      mode: 'Multiple choice',
      viewIsSelected: true,
      boxColor: Colors.deepPurpleAccent,
    ));
    return transport;
  }
}
