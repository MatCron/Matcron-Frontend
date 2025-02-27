import 'package:flutter/material.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';

class GroupDetailsPage extends StatefulWidget {
  final GroupWithMattressesDto group;
  final Function(String) transferOut;
  final Function(String, String) removeMattressFromGroup;
  final bool isImported;
  final bool containsMattresses;

  const GroupDetailsPage(
      {super.key,
      required this.group,
      required this.transferOut,
      required this.removeMattressFromGroup,
      required this.isImported,
      required this.containsMattresses
      });

  @override
  GroupDetailsPageState createState() => GroupDetailsPageState();
}

class GroupDetailsPageState extends State<GroupDetailsPage> {
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
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

  void _performRemove(String mattressId) async {
    bool success = await widget.removeMattressFromGroup(mattressId, widget.group.id);

    if (success) {
      setState(() {
        widget.group.mattressList
            .removeWhere((mattress) => mattress.uid == mattressId);
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
                  organization:
                      widget.group.senderOrganisationName ?? "Unknown",
                  date: _formatDate(widget.group.createdDate),
                  icon: Icons.upload_rounded,
                ),
                const SizedBox(width: 16),
                _buildInfoBox(
                  title: "To",
                  organization:
                      widget.group.receiverOrganisationName ?? "Unknown",
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
                      !widget.isImported ? 
                      GestureDetector(
                        onTap: () {
                          _performRemove(mattress.uid!);
                        },
                        child: Image.asset(
                          "assets/images/minus-button.png",
                          width: 24,
                          height: 24,
                        ),
                      ) : const SizedBox(width: 0),
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
            widget.containsMattresses ? 
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _showTransferOutDialog, // Open confirmation dialog
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
            ) : const SizedBox(width: 0),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(startPageIndex: 1), // Set MattressPage tab
                    ),
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
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
