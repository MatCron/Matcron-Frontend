import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  // Method to launch URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 80, 194, 201),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,  // Adjust if needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Our Story',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Founded in [Year], Our Company has been at the forefront of innovation in the mattress industry, '
              'integrating technology and comfort to provide the best sleep experience possible.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect with Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () =>
                      _launchURL('https://facebook.com/YourFacebookPage'),
                  color: Colors.blue[800],
                  iconSize: 30,
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () =>
                      _launchURL('https://twitter.com/YourTwitterHandle'),
                  color: Colors.blue,
                  iconSize: 30,
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () =>
                      _launchURL('https://instagram.com/YourInstagramHandle'),
                  color: Colors.purple,
                  iconSize: 30,
                ),
                IconButton(
                  icon: const Icon(Icons.link),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/YourLinkedInProfile'),
                  color: Colors.blue[700],
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
