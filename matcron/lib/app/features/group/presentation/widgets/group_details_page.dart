

// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';
// import 'package:matcron/core/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';

// class GroupDetailsPage extends StatefulWidget {
//   final String groupName;
//   final String date;
//   final String fromOrganization;
//   final String toOrganization;
//   final String fromDate;
//   final String toDate;
//   final List<Map<String, String>> mattresses;

//   const GroupDetailsPage({
//     super.key,
//     required this.groupName,
//     required this.date,
//     required this.fromOrganization,
//     required this.toOrganization,
//     required this.fromDate,
//     required this.toDate,
//     required this.mattresses,
//   });

//   @override
//   GroupDetailsPageState createState() => GroupDetailsPageState();
// }

// class GroupDetailsPageState extends State<GroupDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.groupName),
//         backgroundColor: matcronPrimaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with group name and date
//             Text(
//               "Group Details",
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Date: ${widget.date}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     )),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // From and To Information
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildInfoBox(
//                   title: "From",
//                   organization: widget.fromOrganization,
//                   date: widget.fromDate,
//                   icon: Icons.upload,
//                 ),
//                 _buildInfoBox(
//                   title: "To",
//                   organization: widget.toOrganization,
//                   date: widget.toDate,
//                   icon: Icons.download,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Mattress List Header
//             Text(
//               "Mattresses (${widget.mattresses.length})",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Mattress List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.mattresses.length,
//                 itemBuilder: (context, index) {
//                   final mattress = widget.mattresses[index];
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 mattress["type"] ?? "Unknown",
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 mattress["location"] ?? "Unknown",
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoBox({
//     required String title,
//     required String organization,
//     required String date,
//     required IconData icon,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: matcronPrimaryColor, size: 30),
//             const SizedBox(height: 8),
//             Text(title, style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 4),
//             Text(
//               organization,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               date,
//               style: const TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';

class GroupDetailsPage extends StatefulWidget {
  final String groupName;
  final String date;
  final String fromOrganization;
  final String toOrganization;
  final String fromDate;
  final String toDate;
  final List<Map<String, String>> mattresses;

  const GroupDetailsPage({
    Key? key,
    required this.groupName,
    required this.date,
    required this.fromOrganization,
    required this.toOrganization,
    required this.fromDate,
    required this.toDate,
    required this.mattresses,
  }) : super(key: key);

  @override
  GroupDetailsPageState createState() => GroupDetailsPageState();
}

class GroupDetailsPageState extends State<GroupDetailsPage> {
  void _removeMattress(int index) {
    setState(() {
      widget.mattresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.groupName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with group name and date
            const Text(
              "Group Details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Date: ${widget.date}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // From and To section with an arrow in between
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildInfoBox(
                  title: "From",
                  organization: widget.fromOrganization,
                  date: widget.fromDate,
                  icon: Icons.upload_rounded,
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: matcronPrimaryColor, size: 30),
                const SizedBox(width: 8),
                _buildInfoBox(
                  title: "To",
                  organization: widget.toOrganization,
                  date: widget.toDate,
                  icon: Icons.download_rounded,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Mattress List Header
            Text(
              "Mattresses (${widget.mattresses.length})",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Mattress List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.mattresses.length,
              itemBuilder: (context, index) {
                final mattress = widget.mattresses[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Mattress Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mattress["type"] ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              mattress["location"] ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Remove Button
                      GestureDetector(
                        onTap: () {
                          _removeMattress(index);
                        },
                        child: Image.asset(
                          "assets/images/minus-button.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Transfer out logic
                    },
                    icon: const Icon(Icons.exit_to_app, color: Colors.white),
                    label: const Text(
                      "Transfer Out",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: matcronPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add mattresses logic
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Add Mattresses",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: matcronPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build info boxes (From/To)
  Widget _buildInfoBox({
    required String title,
    required String organization,
    required String date,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              organization,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
