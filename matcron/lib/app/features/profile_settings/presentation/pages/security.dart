import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Data Security',
        style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white 
        ),
        backgroundColor:  Color.fromARGB(255, 80, 194, 201),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'How We Protect Your Data',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.security, color:  Color.fromARGB(255, 80, 194, 201)),
              title: const Text('Secure Connections'),
              subtitle: const Text('We use SSL/TLS to secure data in transit.'),
            ),
            ListTile(
              leading: const Icon(Icons.storage, color:  Color.fromARGB(255, 80, 194, 201)),
              title: const Text('Data Encryption'),
              subtitle: const Text('Sensitive data is encrypted at rest and in transit.'),
            ),
            ListTile(
              leading: const Icon(Icons.verified_user, color:  Color.fromARGB(255, 80, 194, 201)),
              title: const Text('Regular Audits'),
              subtitle: const Text('Our systems undergo regular security audits.'),
            ),
            ListTile(
              leading: const Icon(Icons.update, color:  Color.fromARGB(255, 80, 194, 201)),
              title: const Text('Updates'),
              subtitle: const Text('We promptly update software to protect against potential threats.'),
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline, color:  Color.fromARGB(255, 80, 194, 201)),
              title: const Text('Access Control'),
              subtitle: const Text('Strict access controls are in place to ensure that only authorized personnel can access sensitive data.'),
            ),
          ],
        ),
      ),
    );
  }
}
