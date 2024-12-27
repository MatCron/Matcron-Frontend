import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/presentation/pages/scan_page.dart';
import 'package:matcron/app/features/mattress/presentation/widgets/progress_bar.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/constants/constants.dart';

class ImportMattressPage extends StatefulWidget {
  const ImportMattressPage({super.key});

  @override
  ImportMattressPageState createState() => ImportMattressPageState();
}

class ImportMattressPageState extends State<ImportMattressPage> {
  bool _isTapped = false;
  bool _isTapped2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(title: "Import"),
            const SizedBox(height: 20.0),
            ProgressBar(currentStep: 1, labels: progressBarLabels),
            const SizedBox(height: 40.0),

            // Box with GestureDetector
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isTapped = true;
                });

                // Navigate to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanImportPage("single"),
                  )
                );
              },
              onTapUp: (_) {
                setState(() {
                  _isTapped = false;
                });
              },
              onTapCancel: () {
                setState(() {
                  _isTapped = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: _isTapped ? Colors.grey[300] : Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title - centered at the top
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Import Single",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5), // Spacing between title and body
                    // Body: Row with left-aligned text and right-aligned image
                    Row(
                      children: [
                        // Left side: Text
                        Expanded(
                          flex: 2,
                          child: Text(
                            "This is only import one mattress  into the system.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        // Right side: Image
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/single.png',
                            fit: BoxFit.contain,
                            width: 50.0,
                            height: 75.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60.0),

            // Image with VS
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                'assets/images/vs.png',
                width: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 60.0),

            // Box with GestureDetector
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isTapped2 = true;
                });

                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanImportPage("group"),
                  )
                );
              },
              onTapUp: (_) {
                setState(() {
                  _isTapped2 = false;
                });
              },
              onTapCancel: () {
                setState(() {
                  _isTapped2 = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: _isTapped2 ? Colors.grey[300] : Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title - centered at the top
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Import Group",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5), // Spacing between title and body
                    // Body: Row with left-aligned text and right-aligned image
                    Row(
                      children: [
                        // Left side: Text
                        Expanded(
                          flex: 2,
                          child: Text(
                            "If there are multiple mattress to be added into the system and the sender has created a group.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        // Right side: Image
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/group.png',
                            fit: BoxFit.contain,
                            width: 50.0,
                            height: 75.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
