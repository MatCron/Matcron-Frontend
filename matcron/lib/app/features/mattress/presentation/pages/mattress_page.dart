// lib/ui/pages/mattress_page.dart
import 'package:flutter/material.dart';
import '../../../../../core/components/bottom_drawer.dart';

class MattressPage extends StatelessWidget {
  const MattressPage({super.key});

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen dragging behavior
      backgroundColor: Colors.transparent,
      builder: (context) => const BottomDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mattress Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomDrawer(context),
          child: const Text("Open Bottom Drawer"),
        ),
      ),
    );
  }
}
