import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the fade-in animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // 2-second fade-in
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bed.jpg'), // Background image
                fit: BoxFit.cover, // Covers the entire screen
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), // Optional darkening
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Center Logo and Text with Fade Animation
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/MATCRON_Logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 20),
                  // App Name with Custom Font
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.lato(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'Mat'),
                        TextSpan(
                          text: 'Cron',
                          style: GoogleFonts.lato(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
