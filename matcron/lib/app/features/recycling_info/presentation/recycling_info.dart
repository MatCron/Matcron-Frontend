import 'package:flutter/material.dart';

class MattressRecyclingInfoPage extends StatelessWidget {
  const MattressRecyclingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final  titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );
    final bodyStyle = TextStyle(fontSize: 14, color: theme.colorScheme.onSurface);
    final backgroundColor =theme.colorScheme.surface;

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
        "image": 'assets/images/Screwdriver.png'
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
        "image": 'assets/images/handshake.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child:  Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 30,
                color: theme.colorScheme.surface, // Match title color if desired
                   ),
            ),
          ),
        ),
        title:  Text(
          "Mattress Recycling Info",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.surface,
          ),
        ),
        iconTheme:  IconThemeData(color: theme.colorScheme.onSurface),
        // Remove the "X" button entirely
        actions: const [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Learn how to responsibly recycle or donate your mattress. Follow these steps and tips to reduce waste and help the environment.",
                style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 20),
              // Display each section with an image and text
              for (var section in sections) ...[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow:  [
                      BoxShadow(
                        color: theme.colorScheme.onSecondary,
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
