import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background
      body: Stack(
        children: [
          // Adjusted top-left overlapping circles
          Positioned(
            top: -100,
            left: -10,
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2), // Light teal circle
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: -50,
                  child: Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.2), // Lighter teal circle
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Center logo and text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset(
                  'assets/images/MATCRON_Logo.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 30),
                // App name
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: 'Mat'),
                      TextSpan(
                        text: 'Cron',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
