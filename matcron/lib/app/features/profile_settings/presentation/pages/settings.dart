// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; 

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   SettingsPageState createState() => SettingsPageState();
// }

// class SettingsPageState extends State<SettingsPage> {
//   bool _isDarkMode = false; // Default to light mode

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//               leading: InkWell(
//           onTap: () => Navigator.of(context).pop(),
//           child: const Center(
//             child: Text(
//               "<",
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.white, 
//                          ),
//             ),
//           ),
//         ),
//         title: const Text(
//           "Settings",
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color.fromARGB(255, 80, 194, 201),
//         // Ensures the status bar text is appropriately colored in AppBar
//         systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
//           statusBarColor: Color.fromARGB(255, 80, 194, 201),
//           statusBarBrightness: Brightness.light,
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           SwitchListTile(
//             title: const Text('Dark Mode'),
//             subtitle: const Text('Enable dark mode theme'),
//             value: _isDarkMode,
//             onChanged: (bool value) {
//               setState(() {
//                 _isDarkMode = value;
//                 _toggleTheme(value);
//               });
//             },
//             secondary: const Icon(Icons.lightbulb_outline),
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggleTheme(bool darkMode) {
//     if (darkMode) {
//       // Apply dark theme
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle.dark.copyWith(
//           statusBarColor: Colors.black,
//           statusBarBrightness: Brightness.dark,
//         ),
//       );
//     } else {
//       // Apply light theme
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle.light.copyWith(
//           statusBarColor: Colors.white,
//           statusBarBrightness: Brightness.light,
//         ),
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:matcron/config/theme/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state; // Get current theme state
    bool isDarkMode = themeMode == ThemeMode.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, // Dynamic background
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).primaryColor, // Theme-based app bar color
        systemOverlayStyle: isDarkMode
            ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black)
            : SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark mode theme'),
            value: isDarkMode,
            onChanged: (bool value) {
              context.read<ThemeCubit>().toggleTheme(value);
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
    );
  }
}
