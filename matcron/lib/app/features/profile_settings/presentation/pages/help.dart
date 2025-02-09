import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white, 
           
              ),
            ),
          ),
        ),
        title: const Text(
          'Help',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 80, 194, 201),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Welcome, Joe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20), // Provides spacing between the lines
            Text(
              'How Can We Help?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
