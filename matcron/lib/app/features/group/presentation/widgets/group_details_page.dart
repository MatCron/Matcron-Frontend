// import 'package:flutter/material.dart';
// import 'package:matcron/core/constants/constants.dart';

// class GroupDetailsPage extends StatefulWidget {
//   final String groupName;
//   final String date;
//   final String fromOrganization;
//   final String toOrganization;
//   final String fromDate;
//   final String toDate;
//   final List<Map<String, String>> mattresses;
//   final String description;

//   const GroupDetailsPage({
//     super.key,
//     required this.groupName,
//     required this.date,
//     required this.fromOrganization,
//     required this.toOrganization,
//     required this.fromDate,
//     required this.toDate,
//     required this.mattresses, required this.description,
//   });

//   @override
//   GroupDetailsPageState createState() => GroupDetailsPageState();
// }

// class GroupDetailsPageState extends State<GroupDetailsPage> {
//   void _removeMattress(int index) {
//     setState(() {
//       widget.mattresses.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: Text(
//           "Group Details",
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with group name and date
//             const Text(
//               "Group Description",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               widget.description,
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 20),

//             // From and To section with an arrow in between
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _buildInfoBox(
//                   title: "From",
//                   organization: widget.fromOrganization,
//                   date: widget.fromDate,
//                   icon: Icons.upload_rounded,
//                 ),
//                 const SizedBox(width: 8),
//                 Icon(Icons.arrow_forward, color: matcronPrimaryColor, size: 30),
//                 const SizedBox(width: 8),
//                 _buildInfoBox(
//                   title: "To",
//                   organization: widget.toOrganization,
//                   date: widget.toDate,
//                   icon: Icons.download_rounded,
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
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Mattress List
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.mattresses.length,
//               itemBuilder: (context, index) {
//                 final mattress = widget.mattresses[index];
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.grey[300]!),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Mattress Details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               mattress["type"] ?? "Unknown",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               mattress["location"] ?? "Unknown",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Remove Button
//                       GestureDetector(
//                         onTap: () {
//                           _removeMattress(index);
//                         },
//                         child: Image.asset(
//                           "assets/images/minus-button.png",
//                           width: 24,
//                           height: 24,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),

//             // Bottom Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // Transfer out logic
//                     },
//                     icon: const Icon(Icons.exit_to_app, color: Colors.white),
//                     label: const Text(
//                       "Transfer Out",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: matcronPrimaryColor,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // Add mattresses logic
//                     },
//                     icon: const Icon(Icons.add, color: Colors.white),
//                     label: const Text(
//                       "Add Mattresses",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: matcronPrimaryColor,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper to build info boxes (From/To)
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
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey[300]!),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: Colors.blue, size: 30),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               organization,
//               style: const TextStyle(fontSize: 14, color: Colors.black),
//               textAlign: TextAlign.center,
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


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/data/data_sources/group_api_service.dart';
import 'package:matcron/app/features/group/data/repositories/group_repository_impl.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';
import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';
import 'package:matcron/core/constants/constants.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupWithMattressesDto group;

  const GroupDetailsPage({super.key, required this.group});

  @override
  GroupDetailsPageState createState() => GroupDetailsPageState();
}

class GroupDetailsPageState extends State<GroupDetailsPage> {
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Group Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.group.description ?? "No description",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildInfoBox(
                  title: "From",
                  organization: widget.group.senderOrganisationName ?? "Unknown",
                  date: _formatDate(widget.group.createdDate),
                  icon: Icons.upload_rounded,
                ),
                const SizedBox(width: 16),
                _buildInfoBox(
                  title: "To",
                  organization: widget.group.receiverOrganisationName ?? "Unknown",
                  date: widget.group.modifiedDate != null
                      ? _formatDate(widget.group.modifiedDate!)
                      : "N/A",
                  icon: Icons.download_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.group.mattressList.length,
              itemBuilder: (context, index) {
                final mattress = widget.group.mattressList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mattress.mattressTypeName ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              mattress.location ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
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
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 46),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: const Text("Transfer Out", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: matcronPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add Mattresses", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: matcronPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}