// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:matcron/app/features/group/data/models/group.dart';
// import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
// import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
// import 'package:matcron/app/features/organization/domain/entities/organization.dart';
// import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
// import 'package:matcron/core/resources/data_state.dart';
// import '../widgets/add_group_drawer.dart';
// import '../widgets/group_card_widget.dart';
// import 'package:matcron/core/constants/constants.dart';
// import '../widgets/group_details_page.dart';

// class GroupPage extends StatefulWidget {
//   const GroupPage({super.key});

//   @override
//   GroupPageState createState() => GroupPageState();
// }

// class GroupPageState extends State<GroupPage>
//     with SingleTickerProviderStateMixin {
//   List<GroupEntity> activeGroups = [];
//   List<GroupEntity> archivedGroups = [];
//   List<OrganizationEntity> organizations = [];

//   final GroupRepository _groupRepository = GetIt.instance<GroupRepository>();
//   final OrganizationRepository _organizationRepository =
//       GetIt.instance<OrganizationRepository>();

//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _initalizeGroups();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _initalizeGroups() async {
//     var allOrgs = await _organizationRepository.getOrganizations();
//     var activeGroupsState = await _groupRepository.getGroups(1);
//     var archivedGroupsState = await _groupRepository.getGroups(2);

//     setState(() {
//       activeGroups = activeGroupsState.data!;
//       archivedGroups = archivedGroupsState.data!;
//       organizations = allOrgs.data!;
//     });
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
//           onSave: (CreateGroupModel model) {
//             _createGroup(context, model);
//           },
//           purposeController: TextEditingController(),
//           descriptionController: TextEditingController(),
//           organizations: organizations,
//         );
//       },
//     );
//   }

//   void _createGroup(BuildContext context, CreateGroupModel model) async {
//     var createdGroupState = await _groupRepository.createGroup(model);

//     if (createdGroupState is DataSuccess && createdGroupState.data != null) {
//       // Add new group to the active list
//       setState(() {
//         activeGroups.add(createdGroupState.data!);
//       });

//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Success"),
//             content: const Text("Group created successfully!"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Show failure dialog if creation failed
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Error"),
//             content: const Text("Failed to create group. Please try again."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // AppBar to match the color scheme & style you want

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
//             labelColor: matcronPrimaryColor, // Active color for selected tabs
//             unselectedLabelColor:
//                 Colors.grey, // Inactive color for unselected tabs
//             indicatorColor:
//                 matcronPrimaryColor, // Underline indicator for selected tab
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

//   // Builds the list of groups for each tab
//   Widget _buildGroupList(List<GroupEntity> groups) {
//     return ListView.builder(
//       itemCount: groups.length,
//       itemBuilder: (context, index) {
//         final group = groups[index];
//         return GroupCardWidget(
//           groupName: group.name!,
//           organisationName: "",
//           mattressCount: group.mattressCount!,
//           isExport: group.isImported!,
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => GroupDetailsPage(
//                   groupName: group.name!,
//                   date: group.createdDate?.toIso8601String() ?? '',
//                   fromOrganization: group.senderOrganisationName!,
//                   toOrganization: group.receiverOrganisationName!,
//                   description: group.description!,
//                   fromDate: "2025-01-10",
//                   toDate: "2025-01-15",
//                   mattresses: [
//                     {"type": "Memory Foam", "location": "Room 101"},
//                     {"type": "Spring Mattress", "location": "Room 202"},
//                     {"type": "Latex Mattress", "location": "Room 303"},
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import '../widgets/add_group_drawer.dart';
import '../widgets/group_card_widget.dart';
import 'package:matcron/core/constants/constants.dart';
import '../widgets/group_details_page.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  List<GroupEntity> activeGroups = [];
  List<GroupEntity> archivedGroups = [];
  List<OrganizationEntity> organizations = [];

  final GroupRepository _groupRepository = GetIt.instance<GroupRepository>();
  final OrganizationRepository _organizationRepository =
      GetIt.instance<OrganizationRepository>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initalizeGroups();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initalizeGroups() async {
    var allOrgs = await _organizationRepository.getOrganizations();
    var activeGroupsState = await _groupRepository.getGroups(1);
    var archivedGroupsState = await _groupRepository.getGroups(2);

    setState(() {
      activeGroups = activeGroupsState.data!;
      archivedGroups = archivedGroupsState.data!;
      organizations = allOrgs.data!;
    });
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
          onSave: (CreateGroupModel model) {
            _createGroup(context, model);
          },
          purposeController: TextEditingController(),
          descriptionController: TextEditingController(),
          organizations: organizations,
        );
      },
    );
  }

  void _createGroup(BuildContext context, CreateGroupModel model) async {
    var createdGroupState = await _groupRepository.createGroup(model);

    if (createdGroupState is DataSuccess && createdGroupState.data != null) {
      // Add new group to the active list
      setState(() {
        activeGroups.add(createdGroupState.data!);
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Group created successfully!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Show failure dialog if creation failed
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to create group. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            controller: _tabController,
            labelColor: matcronPrimaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: matcronPrimaryColor,
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
  Widget _buildGroupList(List<GroupEntity> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return GroupCardWidget(
          groupName: group.name!,
          organisationName: "",
          mattressCount: group.mattressCount!,
          isExport: group.isImported!,
          onTap: () async {
            // Fetch group details by ID
            final groupDetails = await _groupRepository.getGroupById(group.uid!);
            if (groupDetails is DataSuccess && groupDetails.data != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GroupDetailsPage(
                    group: groupDetails.data!,
                  ),
                ),
              );
            } else {
              // Handle error
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to fetch group details."),
                ),
              );
            }
          },
        );
      },
    );
  }
}