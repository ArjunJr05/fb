// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unused_import

import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:fb/features/user_auth/presentation/pages/notify.dart';

import 'package:fb/features/user_auth/presentation/pages/profile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Profile'),
              subtitle: SoftWrap(
                children: [
                  Text('View Profile'),
                ],
              ),
              leading: Icon(Icons.person, size: 40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Notifications'),
              subtitle: SoftWrap(
                children: [
                  Text('Enable or disable notifications'),
                ],
              ),
              leading: Icon(Icons.notifications, size: 40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationSettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Dark Mode'),
              subtitle: SoftWrap(
                children: [
                  Text('Toggle between light & dark mode'),
                ],
              ),
              leading: Icon(Icons.brightness_6, size: 40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeSelectionPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Language'),
              subtitle: SoftWrap(
                children: [
                  Text('Select your preferred language'),
                ],
              ),
              leading: Icon(Icons.language, size: 40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LanguageSettingsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app, size: 40),
              onTap: () {
                // Navigate to the LogoutPage when Logout is tapped
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            // Add more ListTiles for additional settings options
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}

class SoftWrap extends StatelessWidget {
  final List<Widget> children;

  SoftWrap({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children,
    );
  }
}
