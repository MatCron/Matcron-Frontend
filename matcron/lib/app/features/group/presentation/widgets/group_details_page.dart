import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/group/presentation/widgets/group_history_drawer.dart';
import 'package:matcron/app/features/mattress/data/models/matress.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/resources/nfc_decoder.dart';
import 'package:nfc_manager/nfc_manager.dart';

// ignore: must_be_immutable
class GroupDetailsPage extends StatefulWidget {
  final GroupWithMattressesDto group;
  final Function(String) transferOut;
  final Function(String, String) removeMattressFromGroup;
  final Function(List<String>, String) addNattressesToGroup;
  final bool isImported;
  bool containsMattresses;
  final List<MattressEntity> mattresses;

  GroupDetailsPage(
      {super.key,
      required this.group,
      required this.transferOut,
      required this.removeMattressFromGroup,
      required this.addNattressesToGroup,
      required this.isImported,
      required this.containsMattresses,
      required this.mattresses});

  @override
  GroupDetailsPageState createState() => GroupDetailsPageState();
}

class GroupDetailsPageState extends State<GroupDetailsPage> {
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  final MattressRepository _mattressRepository =
      GetIt.instance<MattressRepository>();

  List<MattressEntity> globalMattresses = [];

  bool _loading = true;
  bool _error = false;

  bool isScanning = true; // NFC scanning status
  bool isFinished = false; // Finished writing status

  @override
  void initState() {
    super.initState();
    _initializeMattresses();
  }

  void _initializeMattresses() async {
    try {
      var allMattresses = widget.mattresses;

      setState(() {
        Set<String> existingMattressIds =
            widget.group.mattressList.map((mattress) => mattress.uid!).toSet();

        globalMattresses = allMattresses.where((mattress) {
          return !existingMattressIds.contains(mattress.uid);
        }).toList();

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
    final theme = Theme.of(context);
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error),
              child: Text("Confirm",
                  style: TextStyle(color: theme.colorScheme.surface)),
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
    final theme = Theme.of(context);
    bool success =
        await widget.removeMattressFromGroup(mattressId, widget.group.id);

    if (success) {
      setState(() {
        widget.group.mattressList
            .removeWhere((mattress) => mattress.uid == mattressId);
        MattressModel mattress = MattressModel(
          uid: m.uid,
          location: m.location,
          type: m.mattressTypeName,
          status: m.status,
        );

        if (widget.group.mattressList.isEmpty) {
          widget.containsMattresses = false;
        }

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
        SnackBar(
          content: Text("Failed to remove mattress from group."),
          backgroundColor: theme.colorScheme.error,
        ),
      );
    }
  }

  Future<bool?> _performAdd(Set<String> mattressIds) async {
    final theme = Theme.of(context);
    final list = mattressIds.toList();
    bool success = await widget.addNattressesToGroup(list, widget.group.id);

    if (success) {
      setState(() {
        widget.containsMattresses = true;
      });
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add mattresses to group."),
          backgroundColor: theme.colorScheme.error,
        ),
      );
      return false;
    }
  }

  void _handleNfcError(String errorMessage) {
    if (!mounted) return;
    setState(() {
      isScanning = false;
    });
    NfcManager.instance.stopSession(errorMessage: errorMessage);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> _startNfcSession() async {
    if (!mounted) return;
    setState(() {
      isScanning = true;
      isFinished = false;
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      try {
        var ndef = Ndef.from(badge);
        if (ndef != null && ndef.cachedMessage != null) {
          var uid = decodeNfcPayload(ndef.cachedMessage!.records[0].payload);
          Set<String> set = {uid};
          var state = await _performAdd(set);
          var mattressState = await _mattressRepository.getMattressById(uid);

          if (state! &&
              mattressState is DataSuccess &&
              mattressState.data != null) {
            setState(() {
              MattressDto mattressDto = MattressDto(
                uid: uid,
                mattressTypeName: mattressState.data!.mattressType!.name,
                location: mattressState.data!.location,
                status: mattressState.data!.status,
              );

              widget.group.mattressList.add(mattressDto);
              globalMattresses.removeWhere((m) {
                return m.uid == uid;
              });
            });

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mattress added to group."),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        } else {
          _handleNfcError("Failed to read NFC tag.");
        }

        await NfcManager.instance.stopSession();

        Future.delayed(Duration(milliseconds: 200), () {
          if (mounted) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (mounted && Navigator.canPop(context)) {
            Navigator.pop(context); // Close modal
          }
        });
      } catch (e) {
        _handleNfcError("Error reading NFC tag: $e");
      }
    });
  }

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

  void _openHistoryBottomDrawer(BuildContext context,
      {required String id}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the drawer to take up full height
      backgroundColor: Colors.transparent, // Matches design
      builder: (context) {
        return GroupHistoryDrawer(
          groupId: id,
        );
      },
    );
  }

  void _openAddMattressDrawer() {
    final theme = Theme.of(context);
    Set<String> selectedIds = {}; // Store selected mattress IDs

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        List<MattressEntity> mattresses = globalMattresses;
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
                height: 550, // Increased height for better visibility
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // **GIF Animation**
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: BoxDecoration(
                    //     color: theme.colorScheme.primary, // Background color
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Center(
                    //     child: Image.asset(
                    //       'assets/images/grouping.gif', // Ensure this path is correct
                    //       height: 100,
                    //       width: 100,
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 10),

                    // **Title**
                    Center(
                      child: Text(
                        "Add Mattresses To Group",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      filled: true,
                      fillColor: theme.scaffoldBackgroundColor,
                    ),

                    const SizedBox(height: 10),

                    // **Search Box**
                    TextField(
                      controller: searchController,
                      onChanged: _filterMattresses,
                      decoration: InputDecoration(
                        hintText: "Search Mattress",
                        hintStyle: TextStyle(color: theme.colorScheme.shadow),
                        prefixIcon:
                            Icon(Icons.search, color: theme.colorScheme.shadow),
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
                        fillColor: theme.cardColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // **List of Mattresses**
                    Expanded(
                      child: filteredMattresses.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredMattresses.length,
                              itemBuilder: (context, index) {
                                String mattressId =
                                    filteredMattresses[index].uid!;
                                return CheckboxListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredMattresses[index].type ??
                                            "Unknown Type",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("Status: ",
                                              style: TextStyle(
                                                  color: theme
                                                      .colorScheme.shadow)),
                                          Text(
                                            "${mattressStatus[filteredMattresses[index].status!]['Text']}",
                                            style: TextStyle(
                                                color: mattressStatus[
                                                        filteredMattresses[
                                                                index]
                                                            .status!]['Color']
                                                    as Color),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Location: ${filteredMattresses[index].location ?? 'Unknown'}",
                                        style: TextStyle(
                                            color: theme.colorScheme.shadow),
                                      ),
                                    ],
                                  ),
                                  checkColor: theme.colorScheme.primary,
                                  activeColor: theme.colorScheme.surface,
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
                            )
                          : Center(
                              child: Text(
                                "No mattresses found",
                                style:
                                    TextStyle(color: theme.colorScheme.shadow),
                              ),
                            ),
                    ),

                    const SizedBox(height: 10),

                    // **Buttons Row**
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel Button
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text("Cancel",
                              style:
                                  TextStyle(color: theme.colorScheme.surface)),
                        ),

                        // Add Button
                        ElevatedButton(
                          onPressed: () async {
                            if (selectedIds.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("No mattresses selected."),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            bool? added = await _performAdd(selectedIds);
                            if (mounted && added!) {
                              setState(() {
                                for (var mattress in mattresses.where(
                                    (m) => selectedIds.contains(m.uid))) {
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

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Mattresses added to group."),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text("Add Mattresses",
                              style:
                                  TextStyle(color: theme.colorScheme.surface)),
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
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.scaffoldBackgroundColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.secondary, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              organization,
              style:
                  TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(fontSize: 14, color: theme.colorScheme.shadow),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        iconTheme:  IconThemeData(color: theme.colorScheme.surface),
        title:  Text(
          "Group Details",
          style: TextStyle(
            color: theme.colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
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
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.group.description ?? "No description",
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.colorScheme.shadow,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                _openHistoryBottomDrawer(context, id: widget.group.id);
                              },
                              label: Text("View History",
                                  style: TextStyle(
                                      color: theme.colorScheme.surface)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
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
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: theme.cardColor),
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        mattress.location ?? "Unknown",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: theme.colorScheme.shadow,
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
                      icon: Icon(Icons.exit_to_app,
                          color: theme.colorScheme.surface),
                      label: Text("Transfer Out",
                          style: TextStyle(color: theme.colorScheme.surface)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
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
                icon: Icon(Icons.add, color: theme.colorScheme.surface),
                label: Text("Add Mattresses",
                    style: TextStyle(color: theme.colorScheme.surface)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
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
