import 'package:flutter/material.dart';

class TransferDonePage extends StatelessWidget {
  const TransferDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for soap icon and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Soap Icon
                Image.asset(
                  'assets/images/soap.png',
                  width: 60,
                  height: 60,
                ),

                // Close Icon
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            const Spacer(), 

            // Transfer Done Text
            const Text(
              "TRANSFER",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Text(
              "DONE",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // Success Icon
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),

            const Spacer(), // Adds space below the main content
          ],
        ),
      ),
    );
  }
}

