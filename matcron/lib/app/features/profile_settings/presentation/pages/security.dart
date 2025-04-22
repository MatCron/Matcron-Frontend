import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
     appBar: AppBar(
  backgroundColor: Theme.of(context).primaryColor,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child:  Icon(Icons.arrow_back, color: theme.colorScheme.surface),
      ),
    ),
  ),
  title:  Text(
    "Security",
    style: TextStyle(
      color: theme.colorScheme.surface,
      fontWeight: FontWeight.bold,
    ),
  ),
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
              leading:  Icon(Icons.security, color:theme.colorScheme.primary),
              title: const Text('Secure Connections'),
              subtitle: const Text('We use SSL/TLS to secure data in transit.'),
            ),
            ListTile(
              leading:  Icon(Icons.storage, color:theme.colorScheme.primary),
              title: const Text('Data Encryption'),
              subtitle: const Text('Sensitive data is encrypted at rest and in transit.'),
            ),
            ListTile(
              leading:  Icon(Icons.verified_user, color:theme.colorScheme.primary),
              title: const Text('Regular Audits'),
              subtitle: const Text('Our systems undergo regular security audits.'),
            ),
            ListTile(
              leading:  Icon(Icons.update, color:theme.colorScheme.primary),
              title: const Text('Updates'),
              subtitle: const Text('We promptly update software to protect against potential threats.'),
            ),
            ListTile(
              leading:  Icon(Icons.lock_outline, color:theme.colorScheme.primary),
              title: const Text('Access Control'),
              subtitle: const Text('Strict access controls are in place to ensure that only authorized personnel can access sensitive data.'),
            ),
          ],
        ),
      ),
    );
  }
}
