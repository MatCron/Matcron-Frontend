import 'package:flutter/material.dart';

class MattressRecyclingInfoPage extends StatelessWidget {
  const MattressRecyclingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Common styling
    const titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 80, 194, 201),
    );
    const bodyStyle = TextStyle(fontSize: 14, color: Colors.black54);
    const backgroundColor = Color(0xFFE5E5E5);

    final sections = [
      {
        "title": "Local Recycling Centers",
        "description":
            "Find nearby facilities that accept mattresses for proper recycling. Check local guidelines to ensure your mattress meets the criteria.",
        "image": 'assets/images/recycle.jpeg'
      },
      {
        "title": "Disassembly Steps",
        "description":
            "Carefully remove the cover, separate foam layers, and take out the springs. Wear gloves for safety. Most centers prefer components separated.",
        "image":'assets/images/Screwdriver.png'
      },
      {
        "title": "Material-Specific Tips",
        "description":
            "Foam can be repurposed for padding, springs recycled as scrap, and fabrics reused. Ask your facility what materials they accept.",
        "image": 'assets/images/fabric-roll.jpg'
      },
      {
        "title": "Donation Options",
        "description":
            "If the mattress is in good condition, consider donating it to local shelters or charities. They may refurbish it for those in need.",
        "image": 'assets/images/redheart.png'
      },
      {
        "title": "Environmental Benefits",
        "description":
            "Recycling mattresses reduces landfill waste and conserves resources. Springs become new metal products, foam may be used in insulation.",
        "image": 'assets/images/globe.png'
      },
      {
        "title": "Laws & Fees",
        "description":
            "Some regions charge fees or have specific rules. Check with municipal waste services for details on costs and regulations.",
        "image":'assets/images/handshake.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Mattress Recycling Info",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 80, 194, 201),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Learn how to responsibly recycle or donate your mattress. Follow these steps and tips to reduce waste and help the environment.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Display each section with an image and text
              for (var section in sections) ...[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12.0),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Smaller image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          section["image"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10), // Reduced space between image and text

                      // Text section expanded to take more space
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(section["title"]!, style: titleStyle),
                            const SizedBox(height: 6),
                            Text(section["description"]!, style: bodyStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
