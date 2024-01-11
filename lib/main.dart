// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, duplicate_import, unused_element, unused_local_variable, non_constant_identifier_names, avoid_web_libraries_in_flutter, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fb/chat/api_key.dart';
import 'package:fb/chat/chat_page.dart';
import 'package:fb/chat/palm.dart';
import 'package:fb/features/app/splash_screen/splash_screen.dart';
import 'package:fb/features/user_auth/presentation/pages/home_page.dart';
import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:fb/features/user_auth/presentation/pages/name_page.dart';
import 'package:fb/features/user_auth/presentation/pages/profile.dart';
import 'package:fb/features/user_auth/presentation/pages/sign_up.dart';
import 'package:fb/features/user_auth/presentation/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  PalmService.init(kApiKey);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedEmail = prefs.getString('email');
  String? savedPassword = prefs.getString('password');
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCmb0cqIxIfa5-2eC1AC9icsaZjMGTW-hY",
        appId: "1:932370166116:android:caabdb86ccbd0233cb4a71",
        messagingSenderId: "932370166116",
        projectId: "lbff-56b41",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(ProviderScope(child: MyApp(savedEmail, savedPassword)));
}

class MyApp extends StatelessWidget {
  final String? savedEmail;
  final String? savedPassword;

  MyApp(this.savedEmail, this.savedPassword);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Lens',
      home: SplashScreen(
        child: savedEmail != null && savedPassword != null
            ? AutoLoginScreen(savedEmail, savedPassword)
            : LoginPage(),
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/chat': (context) => ChatPage(),
        '/name': (context) => NamePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 99, 20, 235),
          background: Color.fromARGB(255, 238, 236, 239),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class AutoLoginScreen extends StatelessWidget {
  final String? email;
  final String? password;

  AutoLoginScreen(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    // Implement your automatic login logic here using the provided email and password
    // ...

    // For now, we'll just navigate to the HomePage for demonstration purposes
    return HomePage();
  }
}
