// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sort_child_properties_last, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, unused_field, use_build_context_synchronously, unused_import

import 'dart:typed_data';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  State<ProfilePage2> createState() => _ProfilePage3State();
}

class _ProfilePage3State extends State<ProfilePage2> {
  late Uint8List _image;

  // Constructor to initialize _image
  _ProfilePage3State() {
    _image = Uint8List(0);
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _navigateToImageDisplay(img);
  }

  Future<void> updateName() async {
    String newName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String enteredName = ''; // Initialize an empty string

        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Enter Name'),
            content: TextField(
              onChanged: (value) {
                enteredName = value;
              },
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(enteredName);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );

    if (newName != null) {
      // Update the name in Firestore
      // Assuming you have a user document with a 'name' field in the 'userProfile' collection
      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'name': newName});

      // Optionally, you can also update the UI here
      setState(() {
        // Update the name in the UI or perform other actions
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('userProfile')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.data() != null) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        String? imageLink = userData['imageLink'];

                        return CircleAvatar(
                          radius: 64,
                          backgroundImage: imageLink != null
                              ? CachedNetworkImageProvider(imageLink)
                              : null, // Use CachedNetworkImageProvider
                          child: imageLink == null
                              ? const Icon(
                                  Icons.person,
                                  size: 64,
                                  color: Colors.black,
                                )
                              : null,
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 64,
                          child: Icon(
                            Icons.person,
                            size: 64,
                            color: Colors.black,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userProfile')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  String userName = '';
                  if (snapshot.hasData) {
                    userName = snapshot.data!['name'];
                  }

                  return Text(
                    userName,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                },
              ),
              SizedBox(height: 12.0),
              Text(
                FirebaseAuth.instance.currentUser?.email ??
                    'arjunfree256@gmail.com',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Padding(
        padding: const EdgeInsets.only(left: 70),
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
      ),
    );
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Images Selected');
    return Uint8List(0);
  }

  void _navigateToImageDisplay(Uint8List pickedImage) {
    setState(() {
      _image = pickedImage;
    });
  }
}
