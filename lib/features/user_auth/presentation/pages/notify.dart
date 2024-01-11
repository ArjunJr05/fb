// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_import, unused_label, duplicate_import

import 'package:fb/features/user_auth/presentation/pages/home_page.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/home_page2.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/notify2.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/scanner2.dart';
import 'package:fb/features/user_auth/presentation/pages/scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late SharedPreferences _prefs;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = _prefs.getBool('notificationsEnabled') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('notificationsEnabled', _notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Text(
          '         Health Lens',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    _saveSettings(); // Save the state when the switch changes
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              _notificationsEnabled ? 'Enabled' : 'Disabled',
              style: TextStyle(
                fontSize: 16,
                color: _notificationsEnabled ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationSettingsPage(),
  ));
}

class ThemeSelectionPage extends StatefulWidget {
  @override
  _ThemeSelectionPageState createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Text(
          'Health Lens',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Light Mode'),
              leading: Radio(
                value: ThemeMode.light,
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value as ThemeMode;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value as ThemeMode;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Apply theme based on the selected mode
                if (_selectedTheme == ThemeMode.dark) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage2()),
                    result: (route) => false,
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    result: (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: _selectedTheme == ThemeMode.light
                    ? Colors.orange // Light mode button color
                    : Colors.black, // Dark mode button color
                onPrimary: Colors.white,
              ),
              child: Text(
                'Apply Theme',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// language_settings.dart

class LanguageSettingsPage extends StatefulWidget {
  @override
  _LanguageSettingsPageState createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String _selectedLanguage = 'en'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Text(
          'Health Lens',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem<String>(
                  value: 'EUK',
                  child: Text('English UK'),
                ),
                // Add more languages as needed
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveSettings();
                  _showSuccessMessage(_selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Background color of the button
                ),
                child: Text(
                  'Apply Language',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSettings() async {
    // Implement your logic to save language settings
  }

  void _showSuccessMessage(String selectedLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Language Applied'),
          content: Text('Selected Language: $selectedLanguage'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 201, 204),
          title: Text(
            '         Health Lens',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home Screen:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text('- Scan Text Feature'),
                Text('- Text-to-Speech Feature'),
                Text('- Chatbot Feature'),
                SizedBox(height: 16),
                Text(
                  'Scan Text Feature:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                    '- Include a button/icon for text scanning on the home screen.'),
                Text(
                    '- Navigate to a screen where the camera is activated for scanning.'),
                Text(
                    '- Implement OCR to convert scanned text to readable text.'),
                Text('- Display the readable text on the screen.'),
                SizedBox(height: 16),
                Text(
                  'Text-to-Speech Feature:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                    '- Include a button/icon for text-to-speech on the home screen.'),
                Text('- Allow users to select text for speech.'),
                Text('- Implement a text-to-speech engine.'),
                Text('- Provide play, pause, and stop options.'),
                SizedBox(height: 16),
                // Repeat the pattern for other features
                // ...

                SizedBox(height: 16),
                Text(
                  'Additional Features:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text('- User Authentication'),
                Text('- Language Settings'),
                Text('- Theme Settings'),
                Text('- Notification Settings'),
                Text('- Navigation'),
                Text('- Accessibility'),
                Text('- Settings Page'),
                Text('- Feedback Mechanism'),
              ],
            ),
          ),
        ));
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Text(
          '         Health Lens',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'For inquiries, please contact us at:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 12.0),
            Text(
              'health.lens.offi@gmail.com',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Text(
          '         Health Lens',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'For any help, please contact us at:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 12.0),
            Text(
              'health.lens.offi@gmail.com',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
