// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel(
      {required this.name, required this.iconPath, required this.boxColor});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: 'AI & DS',
        iconPath: 'images/chatbot.png',
        boxColor: Colors.deepPurpleAccent));

    categories.add(CategoryModel(
        name: 'B.EEE',
        iconPath: 'images/chatbot.png',
        boxColor: Colors.deepPurpleAccent));

    categories.add(CategoryModel(
        name: 'CSC',
        iconPath: 'images/chatbot.png',
        boxColor: Colors.deepPurpleAccent));

    categories.add(CategoryModel(
        name: 'MECH',
        iconPath: 'images/chatbot.png',
        boxColor: Colors.deepPurpleAccent));

    categories.add(CategoryModel(
        name: 'ECE',
        iconPath: 'images/chatbot.png',
        boxColor: Colors.deepPurpleAccent));
    return categories;
  }
}
