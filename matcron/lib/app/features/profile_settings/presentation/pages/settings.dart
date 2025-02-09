import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Default to light mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
              leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white, 
                         ),
            ),
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 80, 194, 201),
        // Ensures the status bar text is appropriately colored in AppBar
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Color.fromARGB(255, 80, 194, 201),
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark mode theme'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                _toggleTheme(value);
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
    );
  }

  void _toggleTheme(bool darkMode) {
    if (darkMode) {
      // Apply dark theme
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      // Apply light theme
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
        ),
      );
    }
  }
}
