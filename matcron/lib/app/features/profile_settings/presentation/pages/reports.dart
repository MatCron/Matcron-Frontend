import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
            leading: InkWell(
          onTap: () => Navigator.pop(context),
          child:  Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 30,
                color: theme.colorScheme.surface,                 fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title:  Text(
          'Reports',
          style: TextStyle(color: theme.colorScheme.surface),
        ),
        iconTheme:  IconThemeData(color: theme.colorScheme.surface),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: const Center(
        child: Text('No reports available.'), // Placeholder text
      ),
    );
  }
}
