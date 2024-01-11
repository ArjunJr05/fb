// ignore_for_file: unused_import, unused_local_variable, unused_element, await_only_futures, avoid_print

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref =
        storage.ref().child(childName); // Fixed typo: _storage to storage
    UploadTask uploadTask =
        ref.putData(file); // Fixed typo: upload Task to uploadTask
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl; // Added return statement
  }

  Future<String> saveData(
      {required String name, required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      if (name.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('profileImage', file);
        await _firestore.collection('userProfile').add({
          'name': name,
          'imageLink': imageUrl,
        });
        resp = 'success';
      }
    } catch (err) {
      print('Error saving data: $err'); // Print the specific error message
      resp = err.toString();
    }
    return resp;
  }
}
