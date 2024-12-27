import 'package:flutter/material.dart';

class RotationPage extends StatelessWidget {
  const RotationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Updated primary color as requested
    final primaryColor = const Color(0xFF50C2C9);

    // Colors and styles from the design
    final backgroundColor = const Color(0xFFE5E5E5);
    final primaryTextStyle = TextStyle(fontSize: 24, color: primaryColor);
    final cardBackgroundColor = Colors.white;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Title (increased left padding to move text to the right)
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 12.0, 16.0, 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Rotation",
                      style: primaryTextStyle.copyWith(fontSize: 52),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
                      // Close button (top right)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 2.0),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.all(4.0),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          const Text(
                            "RFID is to stay in the middle of the longer side",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 20.0),
                          
                          // Top box scenario (correct orientation) with green dot
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 300,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/box.png', 
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                      top: 160,
                                      left: 180,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                              
                                    const SizedBox(height: 50),
                                    const Icon(Icons.check_circle, color: Colors.green, size: 80),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Default:",
                                      style: TextStyle(fontSize: 24, color: Colors.black87),
                                    ),
                                    const Text(
                                      "Vertical",
                                      style: TextStyle(fontSize: 20, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40.0),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 300,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/box.png',
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                      top: 185,
                                      left: 60,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                     const SizedBox(height: 40),
                                    const Icon(Icons.close, color: Colors.red, size: 100),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Will be difficult\nto access",
                                      style: TextStyle(fontSize: 20, color: Colors.black87),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
