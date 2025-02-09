import 'package:flutter/material.dart';

class RotationPage extends StatelessWidget {
  const RotationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    final primaryColor = const Color(0xFF50C2C9);
    final backgroundColor = const Color(0xFFE5E5E5);
    final primaryTextStyle = TextStyle(fontSize: screenWidth * 0.06, color: primaryColor);
    final cardBackgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 12.0, 16.0, 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Rotation",
                      style: primaryTextStyle.copyWith(fontSize: screenWidth * 0.07),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
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
                          Text(
                            "RFID is to stay in the middle of the longer side",
                            style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.3,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/box.png',
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                      top: screenHeight * 0.15,
                                      left: screenWidth * 0.22,
                                      child: Container(
                                        width: screenWidth * 0.05,
                                        height: screenWidth * 0.05,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight * 0.1),
                                    Icon(Icons.check_circle, color: Colors.green, size: screenWidth * 0.15),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      "Default:",
                                      style: TextStyle(fontSize: screenWidth * 0.055, color: Colors.black87),
                                    ),
                                    Text(
                                      "Vertical",
                                      style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.3,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/box.png',
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                      top: screenHeight * 0.175,
                                      left: screenWidth * 0.08,
                                      child: Container(
                                        width: screenWidth * 0.05,
                                        height: screenWidth * 0.05,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight * 0.05),
                                    Icon(Icons.close, color: Colors.red, size: screenWidth * 0.15),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      "Will be difficult\nto access",
                                      style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black87),
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
