
// import 'package:flutter/material.dart';
// import 'package:matcron/core/constants/constants.dart';
// import '../widgets/add_group_drawer.dart';
// import '../widgets/group_card_widget.dart';
// import '../widgets/group_details_page.dart';
// import 'package:flutter/material.dart';

// import '../widgets/group_card_widget.dart';
// import 'package:flutter/material.dart';

// import '../widgets/group_card_widget.dart';

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
//       "isExport": true,
//     },
//     {
//       "groupName": "Group B",
//       "organisationName": "Organisation Y",
//       "mattressCount": 15,
//       "isExport": true,
//     },
//   ];

//   final List<Map<String, dynamic>> archivedGroups = [
//     {
//       "groupName": "Group C",
//       "organisationName": "Organisation Z",
//       "mattressCount": 5,
//       "isExport": false,
//     },
//     {
//       "groupName": "Group D",
//       "organisationName": "Organisation W",
//       "mattressCount": 8,
//       "isExport": true,
//     },
//     {
//       "groupName": "Group E",
//       "organisationName": "Organisation V",
//       "mattressCount": 12,
//       "isExport": false,
//     },
//   ];

//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                 const SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Placeholder for add group functionality
//                   },
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   label: const Text("Add"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: matcronPrimaryColor,
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
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildGroupList(activeGroups),
//                 _buildGroupList(archivedGroups),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupList(List<Map<String, dynamic>> groups) {
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
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (_) => GroupDetailsPage(
//                 groupName: group["groupName"],
//                 date: "2025-01-19",
//                 fromOrganization: group["organisationName"],
//                 toOrganization: group["organisationName"],
//                 fromDate: "2025-01-10",
//                 toDate: "2025-01-15",
//                 mattresses: [
//                   {"type": "Memory Foam", "location": "Room 101"},
//                   {"type": "Spring Mattress", "location": "Room 202"},
//                   {"type": "Latex Mattress", "location": "Room 303"},
//                 ],
//               ),
//             ));
//           },
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'add_group_drawer.dart';

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
//       "isExport": true,
//     },
//     {
//       "groupName": "Group B",
//       "organisationName": "Organisation Y",
//       "mattressCount": 15,
//       "isExport": true,
//     },
//   ];

//   final List<Map<String, dynamic>> archivedGroups = [
//     {
//       "groupName": "Group C",
//       "organisationName": "Organisation Z",
//       "mattressCount": 5,
//       "isExport": false,
//     },
//     {
//       "groupName": "Group D",
//       "organisationName": "Organisation W",
//       "mattressCount": 8,
//       "isExport": true,
//     },
//     {
//       "groupName": "Group E",
//       "organisationName": "Organisation V",
//       "mattressCount": 12,
//       "isExport": false,
//     },
//   ];

//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _openAddDrawer() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       builder: (context) {
//         return AddGroupDrawer(
//           nameController: TextEditingController(),
//           selectedOrganization: "",
//           onOrganizationChanged: (value) {},
//           purposeController: "",
//           descriptionController: TextEditingController(),
//           organizations: List.generate(5, (index) => "Organization ${index + 1}"),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           "Groups",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Search bar + Add button
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
//                 const SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   onPressed: _openAddDrawer,
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

//           // Tab Views
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildGroupList(activeGroups),
//                 _buildGroupList(archivedGroups),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupList(List<Map<String, dynamic>> groups) {
//     return ListView.builder(
//       itemCount: groups.length,
//       itemBuilder: (context, index) {
//         final group = groups[index];
//         return ListTile(
//           title: Text(group["groupName"]),
//           subtitle: Text(group["organisationName"]),
//           trailing: Text("${group["mattressCount"]} Mattresses"),
//           onTap: () {
//             // Navigate to details page logic
//           },
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../widgets/add_group_drawer.dart';
import '../widgets/group_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';
import '../widgets/add_group_drawer.dart';
import '../widgets/group_card_widget.dart';
import '../widgets/group_details_page.dart';
import 'package:flutter/material.dart';// Make sure this import points to your new GroupDetailsPage file
import 'package:flutter/material.dart';
import '../widgets/add_group_drawer.dart';
import '../widgets/group_card_widget.dart';

import 'package:matcron/core/constants/constants.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> activeGroups = [
    {
      "groupName": "Group A",
      "organisationName": "Fairways",
      "mattressCount": 10,
      "isExport": true,
    },
    {
      "groupName": "Group B",
      "organisationName": "Gateway ",
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

    void _openAddDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return AddGroupDrawer(
          nameController: TextEditingController(),
          selectedOrganization: "",
          onOrganizationChanged: (value) {},
          purposeController: "",
          descriptionController: TextEditingController(),
          organizations: List.generate(5, (index) => "Organization ${index + 1}"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar to match the color scheme & style you want
  
      body: Column(
        children: [
          // Search bar + Add button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                  onPressed: _openAddDrawer,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:matcronPrimaryColor,
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
            labelColor: matcronPrimaryColor, // Active color for selected tabs
            unselectedLabelColor: Colors.grey, // Inactive color for unselected tabs
            indicatorColor: matcronPrimaryColor, // Underline indicator for selected tab
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Archived"),
            ],
          ),

          // Tab Views
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

  // Builds the list of groups for each tab
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
            Navigator.of(context).push(
              MaterialPageRoute(
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
              ),
            );
          },
        );
      },
    );
  }
}
