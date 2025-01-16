import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';

class GroupDrawer extends StatelessWidget {
  final String groupName;
  final String date;
  final String fromOrganization;
  final String toOrganization;
  final String fromDate;
  final String toDate;
  final List<Map<String, String>> mattresses;

  const GroupDrawer({
    super.key,
    required this.groupName,
    required this.date,
    required this.fromOrganization,
    required this.toOrganization,
    required this.fromDate,
    required this.toDate,
    required this.mattresses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                groupName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Sender, Symbol, and Receiver Boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoBox(
                icon: Icons.upload_outlined,
                iconColor: matcronPrimaryColor,
                title: "From",
                organization: fromOrganization,
                date: fromDate,
              ),
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Sending",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              _buildInfoBox(
                icon: Icons.download_outlined,
                iconColor: Colors.green,
                title: "To",
                organization: toOrganization,
                date: toDate,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Mattresses List Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mattresses",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${mattresses.length} mattresses",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Mattresses List
          Expanded(
            child: ListView.builder(
              itemCount: mattresses.length + 1, // Includes Add Mattress Button
              itemBuilder: (context, index) {
                if (index < mattresses.length) {
                  final mattress = mattresses[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Darker tile background
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mattress["type"] ?? "Unknown Type",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                mattress["location"] ?? "Unknown Location",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/images/minus-button.png', // Custom remove icon
                            height: 20.0, // Smaller size
                            width: 20.0,
                          ),
                          onPressed: () {
                            _removeMattress(context, mattress);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Add Mattress Button
                  return GestureDetector(
                    onTap: () {
                      // Handle Add Mattress Action
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: matcronPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Add Mattress",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String organization,
    required String date,
  }) {
    return Container(
      width: 140.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 30.0),
          const SizedBox(height: 8.0),
          Text(title, style: TextStyle(fontSize: 12.0, color: Colors.grey[600])),
          const SizedBox(height: 4.0),
          Text(organization,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 4.0),
          Text(date,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              )),
        ],
      ),
    );
  }

  void _removeMattress(BuildContext context, Map<String, String> mattress) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${mattress["type"]} removed from group."),
      ),
    );
  }
}