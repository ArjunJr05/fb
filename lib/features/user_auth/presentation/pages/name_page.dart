// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_import

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb/features/user_auth/presentation/pages/home_page.dart'; // Import your HomePage widget
import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  Uint8List _image = Uint8List(0);
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Images Selected');
      return Uint8List(0);
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _navigateToImageDisplay(img);
  }

  void _navigateToImageDisplay(Uint8List pickedImage) {
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> saveProfileAndNavigate() async {
    String name = _nameController.text;

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && name.isNotEmpty) {
      String userId = user.uid;

      // Save profile data to Firebase Firestore
      await saveProfile(userId, name, _image);

      // Navigate to the HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    }
  }

  Future<void> saveProfile(String userId, String name, Uint8List image) async {
    try {
      // Upload image to Firebase Storage
      String imagePath = 'images/$userId/profile.jpg';
      await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .putData(image);

      // Get the download URL of the uploaded image
      String imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .getDownloadURL();

      // Save profile data to Firebase Firestore
      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(userId)
          .set({
        'name': name,
        'imageLink': imageUrl,
      });
    } catch (error) {
      print('Error saving profile: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _image.isNotEmpty
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          child: Icon(
                            Icons.person,
                            size: 64,
                            color: Colors.black,
                          ),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                    bottom: -10,
                    left: 80,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          // Save the name and perform other actions
                          saveProfileAndNavigate();
                        },
                        child: Text('Save'),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 25, 201, 204),
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
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: NamePage(),
  ));
}
