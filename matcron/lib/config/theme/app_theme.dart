
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Define light theme
ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: HexColor('50C2C9'), // Light theme primary color
    scaffoldBackgroundColor:HexColor('E7E8E8'),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF50C2C9), // Light mode app bar
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF50C2C9), // Primary button color
      secondary: Colors.blue, // Secondary color
      background: Colors.white,
      surface: Colors.white,
      onPrimary: Colors.white,
            onSecondary: Colors.black12,
             shadow: Colors.grey,
      onBackground: Colors.black,
      onSurface: Colors.black87,
      error: Color(0xFFFF5252), 
      // Red Accent for error
       ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
      cardColor: const Color.fromARGB(229, 229, 229, 229), // Light mode container background
        dividerColor: Colors.black26,

          );
}

// Define dark theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: HexColor('38A3A5'), // Dark theme primary color
 scaffoldBackgroundColor: Color.fromARGB(255, 17, 17, 17),
       appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF38A3A5), // Dark mode app bar
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF38A3A5), // Dark theme primary color
      secondary: Color(0xFF22577A), // Dark mode secondary color
      background: Color(0xFF121212), // Dark background
      surface: Colors.black, // Darker shade for surfaces
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
      shadow: Colors.grey,
      error: Color(0xFFCF6679), // Softer red for dark mode errors
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    cardColor: Color.fromARGB(255, 17, 17, 17), // Dark mode container background
    dividerColor: Colors.white24, // Divider color for dark mode
  );
}
