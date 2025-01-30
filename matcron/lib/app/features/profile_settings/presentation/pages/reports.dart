import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

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
                fontSize: 30,
                color: Colors.white,                 fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 80, 194, 201),
      ),
      body: const Center(
        child: Text('No reports available.'), // Placeholder text
      ),
    );
  }
}
