import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';

class Header extends StatefulWidget {
  final String title;

  Header({Key? key, required this.title}) : super(key: key);

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
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
              color: matcronPrimaryColor
            ),
          ),
          
          // Profile and Notification Icons
          Row(
            children: [
              // {Profile
              CircleAvatar(
                radius: 20.0, // Small rounded profile icon
                backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with actual image
              ),
              
              SizedBox(width: 10),

              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: matcronPrimaryColor, // Notification icon background color
                  shape: BoxShape.circle,
                ),
                child: Icon(
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
