import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('History',
        style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white 
        ),
        backgroundColor:  Color.fromARGB(255, 80, 194, 201),  
      ),
      body: Center(
        child: Text('No history available.'),  
      ),
    );
  }
}
