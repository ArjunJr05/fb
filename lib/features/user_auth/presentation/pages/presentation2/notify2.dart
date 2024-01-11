// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_import, unused_label, use_build_context_synchronously, unused_element

import 'package:fb/features/user_auth/presentation/pages/home_page.dart';
import 'package:fb/features/user_auth/presentation/pages/notify.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/home_page2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
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
    ),
  );
}

class NotificationSettingsPage2 extends StatefulWidget {
  @override
  _NotificationSettingsPage2State createState() =>
      _NotificationSettingsPage2State();
}

class _NotificationSettingsPage2State extends State<NotificationSettingsPage2> {
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
      backgroundColor: Colors.black45,
      appBar: _appBar(context),
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
                    color: Colors.white,
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
    home: NotificationSettingsPage2(),
  ));
}

class ThemeSelectionPage2 extends StatefulWidget {
  @override
  _ThemeSelectionPage2State createState() => _ThemeSelectionPage2State();
}

class _ThemeSelectionPage2State extends State<ThemeSelectionPage2> {
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                'Light Mode',
                style: TextStyle(color: Colors.white),
              ),
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
              title: Text(
                'Dark Mode',
                style: TextStyle(color: Colors.white),
              ),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  result:
                  (route) => false;
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 25, 201, 204), // Background color of the button
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

//lang

class LanguageSettingsPage2 extends StatefulWidget {
  @override
  _LanguageSettingsPage2State createState() => _LanguageSettingsPage2State();
}

class _LanguageSettingsPage2State extends State<LanguageSettingsPage2> {
  String _selectedLanguage = 'en'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language:',
              style: TextStyle(
                color: Colors.white,
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
                  child: Text('English',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 201, 204),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                ),
                DropdownMenuItem<String>(
                  value: 'EUK',
                  child: Text('English UK',
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 201, 204),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
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
                  primary: Color.fromARGB(
                      255, 25, 201, 204), // Background color of the button
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

class AboutScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        appBar: _appBar(context),
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
                    color: Colors.white,
                  ),
                ),
                Text('- Scan Text Feature',
                    style: TextStyle(color: Colors.white)),
                Text('- Text-to-Speech Feature',
                    style: TextStyle(color: Colors.white)),
                Text('- Chatbot Feature',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text(
                  'Scan Text Feature:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                    '- Include a button/icon for text scanning on the home screen.',
                    style: TextStyle(color: Colors.white)),
                Text(
                    '- Navigate to a screen where the camera is activated for scanning.',
                    style: TextStyle(color: Colors.white)),
                Text(
                    '- Implement OCR to convert scanned text to readable text.',
                    style: TextStyle(color: Colors.white)),
                Text('- Display the readable text on the screen.',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                Text(
                  'Text-to-Speech Feature:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                    '- Include a button/icon for text-to-speech on the home screen.',
                    style: TextStyle(color: Colors.white)),
                Text('- Allow users to select text for speech.',
                    style: TextStyle(color: Colors.white)),
                Text('- Implement a text-to-speech engine.',
                    style: TextStyle(color: Colors.white)),
                Text('- Provide play, pause, and stop options.',
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 16),
                SizedBox(height: 16),
                Text(
                  'Additional Features:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text('- User Authentication',
                    style: TextStyle(color: Colors.white)),
                Text('- Language Settings',
                    style: TextStyle(color: Colors.white)),
                Text('- Theme Settings', style: TextStyle(color: Colors.white)),
                Text('- Notification Settings',
                    style: TextStyle(color: Colors.white)),
                Text('- Navigation', style: TextStyle(color: Colors.white)),
                Text('- Accessibility', style: TextStyle(color: Colors.white)),
                Text('- Settings Page', style: TextStyle(color: Colors.white)),
                Text('- Feedback Mechanism',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ));
  }
}

class ContactUsPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'For inquiries, please contact us at:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
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

class GetHelp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'For inquiries, please contact us at:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
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
