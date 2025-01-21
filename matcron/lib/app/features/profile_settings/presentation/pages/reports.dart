import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reports',
        style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white 
        ),
        backgroundColor: Color.fromARGB(255, 80, 194, 201),  // Customize color as needed
      ),
      body: Center(
        child: Text('No reports available.'),  // Placeholder text
      ),
    );
  }
}
