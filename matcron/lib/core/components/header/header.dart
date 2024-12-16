import 'package:flutter/material.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart'; // Replace with correct path for InitialScreens

class Header extends StatefulWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  final AuthorizationService _authService = AuthorizationService();

  void _logout() async {
    _authService.deleteToken(); // Delete token
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InitialScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: matcronPrimaryColor,
            ),
          ),
          
          // Profile, Dropdown Menu, and Notifications
          Row(
            children: [
              // Dropdown for Profile & Logout
              PopupMenuButton<String>(
                icon: CircleAvatar(
                  radius: 20.0, 
                  backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with actual image
                ),
                onSelected: (value) {
                  if (value == 'Logout') {
                    _logout();
                  } else if (value == 'Profile') {
                    // Navigate to Profile Page (implement later)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile page not implemented yet!")),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Profile',
                    child: Text('Profile'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ],
              ),
              
              const SizedBox(width: 10),

              // Notification Icon
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: matcronPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
