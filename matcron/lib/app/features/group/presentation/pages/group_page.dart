import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
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

class GroupPageState extends State<GroupPage> with SingleTickerProviderStateMixin {
  List<GroupEntity> activeGroups = [];
  List<GroupEntity> archivedGroups = [];
  List<OrganizationEntity> organizations = [];
  List<MattressEntity> mattresses = [];

  final GroupRepository _groupRepository = GetIt.instance<GroupRepository>();
  final OrganizationRepository _organizationRepository = GetIt.instance<OrganizationRepository>();
    final MattressRepository _mattressRepository =
      GetIt.instance<MattressRepository>();

  late TabController _tabController;
  bool _loading = true; // New: Tracks if groups are still loading
  bool _error = false;  // Tracks if there was an error

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeGroups();
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Fetch Groups and Organizations
  void _initializeGroups() async {
    try {
      var allOrgs = await _organizationRepository.getOrganizations();
      var activeGroupsState = await _groupRepository.getGroups(1);
      var archivedGroupsState = await _groupRepository.getGroups(2);
      var allMattresses = await _mattressRepository.getMattresses();

      setState(() {
        organizations = allOrgs.data ?? [];
        activeGroups = activeGroupsState.data ?? [];
        archivedGroups = archivedGroupsState.data ?? [];
        mattresses = allMattresses.data ?? []; 
        _loading = false; // Data is fully loaded
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true; // Set error state
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load groups. Please try again.")),
      );
    }
  }

  /// Transfer Out a Group
  void _transferOut(String uid) async {
  var transferOutState = await _groupRepository.transferOut(uid);

  if (transferOutState is DataSuccess) {
    // Close the current screen
    if (mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Transfer Out confirmed!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
    }

    // Show success notification
    if (mounted) {
      
    }
    
  } else {
    // Show error notification
    if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error occurred while transferring out."),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
    }
  }
}

  /// Open Add Group Drawer
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

  /// Create a Group
  void _createGroup(BuildContext context, CreateGroupModel model) async {
    var createdGroupState = await _groupRepository.createGroup(model);

    if (createdGroupState is DataSuccess && createdGroupState.data != null) {
      setState(() {
        activeGroups.add(createdGroupState.data!);
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Group created successfully!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to create group. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> _removeMattressFromGroup(String mattressId, String groupId) async {
    List<String> mattressIds  = [];
    mattressIds.add(mattressId);
    
    var groupModel = EditMattressesToGroupModel(groupId: groupId, mattressIds: mattressIds);
    
    var state = await _groupRepository.removeMattressFromGroup(groupModel);

    if (state is DataSuccess) {
      setState(() {
        var group = activeGroups.where((group) => group.uid == groupId).first;
        group.mattressCount = group.mattressCount! - 1;
      });

      return true;
    } else {
      return false;
    }
  }

  Future<bool> _addMattressesToGroup(List<String> mattresses, String groupId) async {
    var mattressToAdd = EditMattressesToGroupModel(groupId: groupId, mattressIds: mattresses);
    var state = await _groupRepository.addMattressToGroup(mattressToAdd);

    if (state is DataSuccess) {
      setState(() {
        var group = activeGroups.where((group) => group.uid == groupId).first;
        group.mattressCount = group.mattressCount! +  mattresses.length;
      });

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator(color: matcronPrimaryColor,)) // Show loading spinner
          : _error
              ? const Center(child: Text("Error loading groups. Try again later."))
              : Column(
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
                            label: const Text("Add", style: TextStyle(color: Colors.white)),
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

  /// Builds the list of groups
  Widget _buildGroupList(List<GroupEntity> groups) {
    if (groups.isEmpty) {
      return const Center(child: Text("No groups available", style: TextStyle(color: Colors.grey)));
    }
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
            final groupDetails = await _groupRepository.getGroupById(group.uid!);
            if (groupDetails is DataSuccess && groupDetails.data != null) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GroupDetailsPage(
                    group: groupDetails.data!,
                    transferOut: _transferOut, 
                    removeMattressFromGroup: _removeMattressFromGroup,
                    addNattressesToGroup: _addMattressesToGroup,
                    isImported: group.isImported!,
                    containsMattresses: group.mattressCount! > 0,
                    mattresses: mattresses,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to fetch group details.")),
              );
            }
          },
        );
      },
    );
  }
}
