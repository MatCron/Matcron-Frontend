
// import 'package:flutter/material.dart';
// import '../widgets/group_card_widget.dart';
// import '../widgets/drawer_page.dart'; // Import the DrawerPage widget

// class GroupPage extends StatefulWidget {
//   const GroupPage({super.key});

//   @override
//   GroupPageState createState() => GroupPageState();
// }

// class GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
//   final List<Map<String, dynamic>> activeGroups = [
//     {
//       "groupName": "Group A",
//       "organisationName": "Organisation X",
//       "mattressCount": 10,
//       "isExport": true
//     },
//     {
//       "groupName": "Group B",
//       "organisationName": "Organisation Y",
//       "mattressCount": 15,
//       "isExport": true
//     },
//   ];

//   final List<Map<String, dynamic>> archivedGroups = [
//     {
//       "groupName": "Group C",
//       "organisationName": "Organisation Z",
//       "mattressCount": 5,
//       "isExport": false
//     },
//     {
//       "groupName": "Group D",
//       "organisationName": "Organisation W",
//       "mattressCount": 8,
//       "isExport": true
//     },
//     {
//       "groupName": "Group E",
//       "organisationName": "Organisation V",
//       "mattressCount": 12,
//       "isExport": false
//     },
//   ];

//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Two tabs: Active and Archived
//   }

//   @override
//   void dispose() {
//     _tabController.dispose(); // Dispose of the TabController
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Groups"),
//       //   backgroundColor: Colors.blue,
//       // ),
//       body: Column(
//         children: [
//           // Search bar and Add button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search groups",
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10.0),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Handle Add Group Action
//                   },
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   label: const Text(
//                     "Add",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Tabs
//           TabBar(
//             controller: _tabController,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.blue,
//             tabs: const [
//               Tab(text: "Active"),
//               Tab(text: "Archived"),
//             ],
//           ),
//           const SizedBox(height: 10.0),
//           // TabBarView
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // Active Tab
//                 _buildGroupList(activeGroups),

//                 // Archived Tab
//                 _buildGroupList(archivedGroups),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupList(List<Map<String, dynamic>> groups) {
//     if (groups.isEmpty) {
//       return Center(
//         child: Text(
//           "No groups available",
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: groups.length,
//       itemBuilder: (context, index) {
//         final group = groups[index];
//         return GroupCardWidget(
//           groupName: group["groupName"],
//           organisationName: group["organisationName"],
//           mattressCount: group["mattressCount"],
//           isExport: group["isExport"],
//           onTap: () {
//             _openDrawer(context, group);
//           },
//         );
//       },
//     );
//   }

//   void _openDrawer(BuildContext context, Map<String, dynamic> group) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent, // Transparent background
//       builder: (context) => GroupDrawer(
//         groupName: group["groupName"],
//         date: "2025-01-19", // Example date (use dynamic value if needed)
//         fromOrganization: group["organisationName"],
//         toOrganization: group["organisationName"], // Adjust as per your data
//         fromDate: "2025-01-10", // Example start date
//         toDate: "2025-01-15", // Example end date
//         mattresses: [
//           {"type": "Memory Foam", "location": "Room 101"},
//           {"type": "Spring Mattress", "location": "Room 202"},
//           {"type": "Latex Mattress", "location": "Room 303"},
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../widgets/add_group_drawer.dart';
import '../widgets/group_card_widget.dart';
import '../widgets/group_details_page.dart';
import 'package:flutter/material.dart';

import '../widgets/group_card_widget.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> activeGroups = [
    {
      "groupName": "Group A",
      "organisationName": "Organisation X",
      "mattressCount": 10,
      "isExport": true,
    },
    {
      "groupName": "Group B",
      "organisationName": "Organisation Y",
      "mattressCount": 15,
      "isExport": true,
    },
  ];

  final List<Map<String, dynamic>> archivedGroups = [
    {
      "groupName": "Group C",
      "organisationName": "Organisation Z",
      "mattressCount": 5,
      "isExport": false,
    },
    {
      "groupName": "Group D",
      "organisationName": "Organisation W",
      "mattressCount": 8,
      "isExport": true,
    },
    {
      "groupName": "Group E",
      "organisationName": "Organisation V",
      "mattressCount": 12,
      "isExport": false,
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar and Add button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search groups",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Placeholder for add group functionality
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tabs
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Archived"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGroupList(activeGroups),
                _buildGroupList(archivedGroups),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupList(List<Map<String, dynamic>> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return GroupCardWidget(
          groupName: group["groupName"],
          organisationName: group["organisationName"],
          mattressCount: group["mattressCount"],
          isExport: group["isExport"],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => GroupDetailsPage(
                groupName: group["groupName"],
                date: "2025-01-19",
                fromOrganization: group["organisationName"],
                toOrganization: group["organisationName"],
                fromDate: "2025-01-10",
                toDate: "2025-01-15",
                mattresses: [
                  {"type": "Memory Foam", "location": "Room 101"},
                  {"type": "Spring Mattress", "location": "Room 202"},
                  {"type": "Latex Mattress", "location": "Room 303"},
                ],
              ),
            ));
          },
        );
      },
    );
  }
}
