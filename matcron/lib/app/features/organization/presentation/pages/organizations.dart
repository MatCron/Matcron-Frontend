import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_state.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/bottom_bar/controllers/notch_bottom_bar_controller.dart';
import 'package:matcron/core/constants/constants.dart';

class OrganizationPage extends StatefulWidget {
  final NotchBottomBarController? controller;
  const OrganizationPage({super.key, this.controller});

  @override
  OrganizationPageState createState() => OrganizationPageState();
}

class OrganizationPageState extends State<OrganizationPage> {
  late RemoteOrganizationBloc _organizationBloc;
  final List<OrganizationEntity> hardcodedOrgs = [
    OrganizationEntity(id: "", name: "Gateway", type: "Hotel"),
    OrganizationEntity(id: "", name: "Bellingham", type: "Hotel"),
    OrganizationEntity(id: "", name: "Louth Hospital", type: "Hospital"),
    OrganizationEntity(id: "", name: "Fairways", type: "Hotel"),

    OrganizationEntity(id: "", name: "Gateway", type: "Hotel"),
    OrganizationEntity(id: "", name: "Bellingham", type: "Hotel"),
    OrganizationEntity(id: "", name: "Louth Hospital", type: "Hospital"),
    OrganizationEntity(id: "", name: "Fairways", type: "Hotel"),

    OrganizationEntity(id: "", name: "Gateway", type: "Hotel"),
    OrganizationEntity(id: "", name: "Bellingham", type: "Hotel"),
    OrganizationEntity(id: "", name: "Louth Hospital", type: "Hospital"),
    OrganizationEntity(id: "", name: "Fairways", type: "Hotel"),
  ];
  List<OrganizationEntity> filteredOrgs = [];

  @override
  void initState() {
    super.initState();
    _organizationBloc = sl<RemoteOrganizationBloc>();
    filteredOrgs = hardcodedOrgs; // Initialize the filtered list
  }

  @override
  void dispose() {
    _organizationBloc.close(); // Dispose of the bloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteOrganizationBloc>(
      create: (context) => _organizationBloc,
      child: Scaffold(
        body: BlocBuilder<RemoteOrganizationBloc, RemoteOrganizationState>(
          builder: (_, state) {
            //THIS WHILL CHANGE BUT HARDCODED DATA WILL BE PLACED IN LOADING FN
            if (state is RemoteOrganizationsLoading) {
              return _buildLoadingState(context);
            }
            if (state is RemoteOrganizationsDone) {
              return Container(); // Placeholder for done state
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          color: HexColor("#E5E5E5"),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                onChanged: (query) {
                  setState(() {
                    filteredOrgs = hardcodedOrgs
                        .where((org) => org.name!
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search Organizations",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              const SizedBox(height: 10.0),

              // Add organization button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Add organization functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "+ Add Organization",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),

              // Table headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Name",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Type",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 30.0), // Space between Type and Edit/Delete
                  Text(
                    "Edit",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 40.0), // Space between Edit and Delete
                  Text(
                    "Delete",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              // Display filtered organizations
              Expanded(
                child: ListView.builder(
                  itemCount: filteredOrgs.length,
                  itemBuilder: (context, index) {
                    final org = filteredOrgs[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              org.name!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              org.type!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 30.0), // Space between Type and Edit/Delete
                          GestureDetector(
                            onTap: () {
                              // Edit functionality
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40.0), // Space between Edit and Delete
                          GestureDetector(
                            onTap: () {
                              // Delete functionality
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 14.0,
                              ),
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
        );
      },
    );
  }
}
