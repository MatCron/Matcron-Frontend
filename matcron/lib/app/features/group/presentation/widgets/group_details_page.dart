import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/data/models/matress.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupWithMattressesDto group;
  final Function(String) transferOut;
  final Function(String, String) removeMattressFromGroup;
  final Function(List<String>, String) addNattressesToGroup;
  final bool isImported;
  final bool containsMattresses;

  const GroupDetailsPage(
      {super.key,
      required this.group,
      required this.transferOut,
      required this.removeMattressFromGroup,
      required this.addNattressesToGroup,
      required this.isImported,
      required this.containsMattresses});

  @override
  GroupDetailsPageState createState() => GroupDetailsPageState();
}

class GroupDetailsPageState extends State<GroupDetailsPage> {
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  List<MattressEntity> globalMattresses = [];
  final MattressRepository _mattressRepository =
      GetIt.instance<MattressRepository>();
  bool _loading = true; // New: Tracks if groups are still loading
  bool _error = false; // Tracks if there was an error

  @override
  void initState() {
    super.initState();
    _initializeMattresses();
  }

  void _initializeMattresses() async {
    try {
      var allMattresses = await _mattressRepository.getMattresses();

      setState(() {
        Set<String> existingMattressIds =
            widget.group.mattressList.map((mattress) => mattress.uid!).toSet();

        globalMattresses = allMattresses.data?.where((mattress) {
              return !existingMattressIds.contains(mattress.uid);
            }).toList() ??
            [];

        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to load group. Please try again.")),
      );
    }
  }

  void _showTransferOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Transfer"),
          content:
              const Text("Are you sure you want to transfer out this group?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _performTransferOut(); // Call transfer logic
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text("Confirm", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _performTransferOut() {
    widget.transferOut(widget.group.id);
  }

  void _performRemove(String mattressId, MattressDto m) async {
    bool success =
        await widget.removeMattressFromGroup(mattressId, widget.group.id);

    if (success) {
      setState(() {
        widget.group.mattressList.removeWhere((mattress) => mattress.uid == mattressId);
        MattressModel mattress = MattressModel(
          uid: m.uid,
          location: m.location,
          type: m.mattressTypeName,
          status: m.status,
        );


      globalMattresses.add(mattress); // Add the mattress safely
          });

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mattress removed from group."),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to remove mattress from group."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool?> _performAdd(Set<String> mattressIds) async {
    final list = mattressIds.toList();
    bool success = await widget.addNattressesToGroup(list, widget.group.id);

    if (success) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to add mattresses to group."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<void> _startNfcSession() async {}

  // void _handleNfcError(String errorMessage) {}

  void _openRfidModal(BuildContext context, String session) {
    if (session == 'SEARCH') {
      Future.delayed(Duration(milliseconds: 100), _startNfcSession);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/scan_icon.png',
                  width: 275,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text("Tap On RFID..."),
            ],
          ),
        );
      },
    );
  }

  void _openAddMattressDrawer() {
    // Declare selectedIds outside the builder to persist state
    Set<String> selectedIds = {};

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        List<MattressEntity> mattresses =
            globalMattresses; //CHANNGE THIS TO GET ALL MATTERESES
        List<MattressEntity> filteredMattresses = List.from(mattresses);

        TextEditingController searchController = TextEditingController();

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            void _filterMattresses(String query) {
              setModalState(() {
                if (query.isEmpty) {
                  filteredMattresses = List.from(mattresses);
                } else {
                  filteredMattresses = mattresses.where((mattress) {
                    return (mattress.type ?? "")
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        (mattress.location ?? "")
                            .toLowerCase()
                            .contains(query.toLowerCase());
                  }).toList();
                }
              });
            }

            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 500, // Adjust height as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Mattresses To Group",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: matcronPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              _filterMattresses(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search Mattress",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  'assets/images/scan_icon.png', // Path to your scan icon asset
                                  height: 36,
                                  width: 50,
                                ),
                                onPressed: () {
                                  _openRfidModal(context, 'SEARCH');
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredMattresses.length,
                        itemBuilder: (context, index) {
                          String mattressId = filteredMattresses[index].uid!;
                          return CheckboxListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredMattresses[index].type ??
                                      "Unknown Type",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Status: ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "${mattressStatus[filteredMattresses[index].status!]['Text']}",
                                      style: TextStyle(
                                          color: mattressStatus[
                                              filteredMattresses[index]
                                                  .status!]['Color'] as Color),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Location: ${filteredMattresses[index].location ?? 'Unknown Location'}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            checkColor: matcronPrimaryColor,
                            activeColor: Colors.white,
                            value: selectedIds.contains(mattressId),
                            onChanged: (bool? value) {
                              setModalState(() {
                                if (value == true) {
                                  selectedIds.add(mattressId);
                                } else {
                                  selectedIds.remove(mattressId);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              selectedIds.clear();
                            });
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            List<MattressEntity> selectedMattresses = mattresses
                                .where((mattress) =>
                                    selectedIds.contains(mattress.uid))
                                .toList(); // this is for local adding dynamically
                            //convert to mattressDto

                            if (selectedMattresses.isNotEmpty) {
                              bool? added = await _performAdd(selectedIds);
                              if (mounted && added!) {
                                setState(() {
                                  for (var mattress in selectedMattresses) {
                                    MattressDto mattressDto = MattressDto(
                                      uid: mattress.uid,
                                      mattressTypeName: mattress.type,
                                      location: mattress.location,
                                      status: mattress.status,
                                    );

                                    widget.group.mattressList.add(mattressDto);
                                    globalMattresses.remove(mattress);
                                  }
                                });

                                Navigator.pop(context); // Close drawer
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Mattresses added to group."),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No mattresses selected."),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: matcronPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            "Add Mattresses",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
              color: matcronPrimaryColor,
            )) // Show loading spinner
          : _error
              ? const Center(
                  child: Text("Error loading group. Try again later."))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                            organization: widget.group.senderOrganisationName ??
                                "Unknown",
                            date: _formatDate(widget.group.createdDate),
                            icon: Icons.upload_rounded,
                          ),
                          const SizedBox(width: 16),
                          _buildInfoBox(
                            title: "To",
                            organization:
                                widget.group.receiverOrganisationName ??
                                    "Unknown",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                !widget.isImported
                                    ? GestureDetector(
                                        onTap: () {
                                          _performRemove(
                                              mattress.uid!, mattress);
                                        },
                                        child: Image.asset(
                                          "assets/images/minus-button.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      )
                                    : const SizedBox(width: 0),
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
            widget.containsMattresses
                ? Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          _showTransferOutDialog, // Open confirmation dialog
                      icon: const Icon(Icons.exit_to_app, color: Colors.white),
                      label: const Text("Transfer Out",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: matcronPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  )
                : const SizedBox(width: 0),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _openAddMattressDrawer();
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add Mattresses",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: matcronPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
