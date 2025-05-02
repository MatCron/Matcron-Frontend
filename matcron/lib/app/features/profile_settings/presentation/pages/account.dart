import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final TextEditingController _nameController = TextEditingController(text: "Joe Doe");
  final TextEditingController _emailController = TextEditingController(text: "joe.doe@example.com");
  final TextEditingController _orgCodeController = TextEditingController(text: "ORG123");

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
    "Account",
    style: TextStyle(
      color: theme.colorScheme.surface,
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _orgCodeController,
              decoration: const InputDecoration(
                labelText: 'Organization Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigates back to the previous page
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _orgCodeController.dispose();
    super.dispose();
  }
}
