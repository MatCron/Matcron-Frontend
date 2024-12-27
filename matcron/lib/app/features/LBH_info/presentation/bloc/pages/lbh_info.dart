import 'package:flutter/material.dart';

class MattressDimensionsPage extends StatelessWidget {
  const MattressDimensionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFE5E5E5);
    final primaryColor = const Color.fromARGB(255, 80, 194, 201);
    const labelStyle = TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic);
    const valueStyle = TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Mattress Dimensions",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 80, 194, 201),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Short introduction
              const Text(
                "Here are the detailed dimensions of your mattress. Use this information to ensure proper fitting in your bed frame and bedding.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Cuboid image for visual reference
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/bedmeasuring.png', 
                    width: 200,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Dimension Labels and Values
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Length
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Length", style: labelStyle),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal:20, vertical:10),
                        child: Text("80 inches", style: valueStyle), 
                      )
                    ],
                  ),

                  // Width (Breadth)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Width", style: labelStyle),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal:20, vertical:10),
                        child: Text("60 inches", style: valueStyle), 
                      )
                    ],
                  ),

                  // Depth (Height)	
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Depth/Height", style: labelStyle),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal:20, vertical:10),
                        child: Text("10 inches", style: valueStyle), 
                      )
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

           
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "All measurements are approximate and can vary slightly. Ensure to measure your bed frame and confirm that these dimensions meet your room’s space requirements.",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
