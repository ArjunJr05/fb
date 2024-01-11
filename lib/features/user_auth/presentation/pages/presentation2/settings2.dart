// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unused_import, unused_element

import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:fb/features/user_auth/presentation/pages/notify.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/home_page2.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/notify2.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/profile.dart';
import 'package:fb/features/user_auth/presentation/pages/profile.dart';
import 'package:fb/features/user_auth/presentation/pages/settings.dart';
import 'package:flutter/material.dart';

class SettingsPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          ListTile(
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: SoftWrap2(
              children: [
                Text(
                  'View Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            leading: Icon(Icons.person, size: 40, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage2()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: SoftWrap2(
              children: [
                Text(
                  'Enable or disable notifications',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            leading: Icon(Icons.notifications, size: 40, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationSettingsPage2(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: SoftWrap2(
              children: [
                Text(
                  'Toggle between light & dark mode',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            leading: Icon(Icons.brightness_6, size: 40, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeSelectionPage2(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Language',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: SoftWrap(
              children: [
                Text('Select your preferred language',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            leading: Icon(
              Icons.language,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LanguageSettingsPage2()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.exit_to_app, size: 40, color: Colors.white),
            onTap: () {
              // Navigate to the LogoutPage when Logout is tapped
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ]),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage2(),
  ));
}

class SoftWrap2 extends StatelessWidget {
  final List<Widget> children;

  SoftWrap2({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children,
    );
  }
}
