// import 'package:flutter/material.dart';
// import 'package:matcron/config/theme/app_theme.dart';

// import 'package:matcron/core/constants/constants.dart';


// class GroupPage extends StatefulWidget {
//   const GroupPage({super.key});

//   @override
//   GroupPageState createState() => GroupPageState();
// }

// class GroupPageState extends State<GroupPage> {
//   final List<String> groups = ["Group A", "Group B", "Group C", "Group D"];
//   List<String> filteredGroups = [];
//   int selectedGroupIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     filteredGroups = groups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Groups"),
//       //   backgroundColor: matcronPrimaryColor,
//       // ),
//       body: Container(
//         color: HexColor("#E5E5E5"),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search bar
//             TextField(
//               onChanged: (query) {
//                 setState(() {
//                   filteredGroups = groups
//                       .where((group) => group
//                           .toLowerCase()
//                           .contains(query.toLowerCase()))
//                       .toList();
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: "Search groups",
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Add Group Page
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: matcronPrimaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 14,
//                     ),
//                   ),
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(width: 10.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Import Group Page
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: matcronPrimaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 14,
//                     ),
//                   ),
//                   child: const Icon(Icons.import_export),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15.0),
//             // Table headers
//             Row(
//               children: [
//                 Expanded(
//                   child: Text("Group Name", style: _headerStyle),
//                 ),
//               ],
//             ),
//             const Divider(color: Colors.black26),
//             // Groups List
//             Expanded(
//               child: filteredGroups.isEmpty
//                   ? Center(
//                       child: Text(
//                         "No groups available",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: filteredGroups.length,
//                       itemBuilder: (context, index) {
//                         final group = filteredGroups[index];
//                         final isSelected = selectedGroupIndex == index;

//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedGroupIndex = isSelected ? -1 : index;
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 20.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     group,
//                                     style: _itemTextStyle,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static const TextStyle _headerStyle = TextStyle(
//     fontSize: 16.0,
//     fontStyle: FontStyle.italic,
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//   );

//   static const TextStyle _itemTextStyle = TextStyle(
//     fontSize: 14.0,
//     fontWeight: FontWeight.bold,
//   );
// }



import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'drawer_page.dart'; // Import GroupDrawer widget
import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'drawer_page.dart'; // Import GroupDrawer widget

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  final List<String> groups = ["Group A", "Group B", "Group C", "Group D"];
  List<String> filteredGroups = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    filteredGroups = groups;
    _tabController = TabController(length: 2, vsync: this); // Initialize here
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the controller to avoid memory leaks
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
                    onChanged: (query) {
                      setState(() {
                        filteredGroups = groups
                            .where((group) =>
                                group.toLowerCase().contains(query.toLowerCase()))
                            .toList();
                      });
                    },
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
                const SizedBox(width: 10.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Add Group Action
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
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
            controller: _tabController, // Ensure it's initialized before use
            labelColor: matcronPrimaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: matcronPrimaryColor,
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Archived"),
            ],
          ),
          const SizedBox(height: 10.0),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController, // Ensure it's initialized before use
              children: [
                // Active Tab
                filteredGroups.isEmpty
                    ? Center(
                        child: Text(
                          "No active groups available",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredGroups.length,
                        itemBuilder: (context, index) {
                          final group = filteredGroups[index];

                          return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent, // Ensures the background is visible
                              builder: (context) => GroupDrawer(
                                groupName: "Group A",
                                date: "2025-01-16",
                                fromOrganization: "Organization A",
                                toOrganization: "Organization B",
                                fromDate: "2025-01-10",
                                toDate: "2025-01-15",
                                mattresses: [
                                  {"type": "Memory Foam", "location": "Room 101"},
                                  {"type": "Spring Mattress", "location": "Room 202"},
                                  {"type": "Latex Mattress", "location": "Room 303"},
                                ],
                              ),
                            );
                          },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              elevation: 3,
                              child: ListTile(
                                title: Text(
                                  group,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text("5454 mattresses"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (index == 0)
                                      IconButton(
                                        icon: const Icon(Icons.replay,
                                            color: Colors.blue),
                                        onPressed: () {
                                          // Handle rollback action
                                        },
                                      ),
                                    const SizedBox(width: 10.0),
                                    const Text(
                                      "Active",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                // Archived Tab
                Center(
                  child: Text(
                    "No archived groups available",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}