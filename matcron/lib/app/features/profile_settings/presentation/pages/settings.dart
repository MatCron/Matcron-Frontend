
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
          child:  Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).colorScheme.surface, // Dynamic text color
              ),
            ),
          ),
        ),
        title:  Text("Settings", style:TextStyle(color: Theme.of(context).colorScheme.surface)),
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
