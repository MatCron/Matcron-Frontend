import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

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
    "Reports",
    style: TextStyle(
      color: theme.colorScheme.surface,
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body: const Center(
        child: Text('No reports available.'), // Placeholder text
      ),
    );
  }
}
