import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';

import 'package:matcron/core/constants/constants.dart';


class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> {
  final List<String> groups = ["Group A", "Group B", "Group C", "Group D"];
  List<String> filteredGroups = [];
  int selectedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    filteredGroups = groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Groups"),
      //   backgroundColor: matcronPrimaryColor,
      // ),
      body: Container(
        color: HexColor("#E5E5E5"),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              onChanged: (query) {
                setState(() {
                  filteredGroups = groups
                      .where((group) => group
                          .toLowerCase()
                          .contains(query.toLowerCase()))
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
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
            const SizedBox(height: 10.0),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Group Page
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
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Import Group Page
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
                  child: const Icon(Icons.import_export),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            // Table headers
            Row(
              children: [
                Expanded(
                  child: Text("Group Name", style: _headerStyle),
                ),
              ],
            ),
            const Divider(color: Colors.black26),
            // Groups List
            Expanded(
              child: filteredGroups.isEmpty
                  ? Center(
                      child: Text(
                        "No groups available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredGroups.length,
                      itemBuilder: (context, index) {
                        final group = filteredGroups[index];
                        final isSelected = selectedGroupIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGroupIndex = isSelected ? -1 : index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    group,
                                    style: _itemTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle _headerStyle = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle _itemTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );
}
