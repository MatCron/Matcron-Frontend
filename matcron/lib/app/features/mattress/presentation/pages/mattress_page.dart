// lib/ui/pages/mattress_page.dart
import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/presentation/widgets/bottom_drawer.dart';


class MattressPage extends StatelessWidget {
  const MattressPage({super.key});

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen dragging behavior
      backgroundColor: Colors.transparent,
      builder: (context) => const MattressBottomDrawer()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomDrawer(context),
          child: const Text("Open Bottom Drawer"),
        ),
      ),
    );
  }
}
