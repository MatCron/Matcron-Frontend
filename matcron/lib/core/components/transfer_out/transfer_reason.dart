import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/transfer_out/transfer_confirm.dart';
import 'package:matcron/core/constants/constants.dart';

class TransferOutMattressPage extends StatefulWidget {
  final List<GroupEntity> groups;

  TransferOutMattressPage({super.key, required List<GroupEntity> groups})
      : groups = _removeDuplicates(groups); // Filter duplicates before passing to state

  @override
  _TransferOutMattressPageState createState() => _TransferOutMattressPageState();

  // Function to remove duplicates based on UID
  static List<GroupEntity> _removeDuplicates(List<GroupEntity> groups) {
    final seen = <String>{};
    return groups.where((group) {
      if (group.uid == null || seen.contains(group.uid)) {
        return false; // Skip duplicate
      }
      seen.add(group.uid!);
      return true;
    }).toList();
  }
}

class _TransferOutMattressPageState extends State<TransferOutMattressPage> {
  String? selectedGroupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#E5E5E5"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Close button in the top right corner
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 40), // Adjust spacing

            // Title
            const Text(
              "Transfer Out Mattress",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Dropdown for selecting group
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                hint: const Text("Select Group"),
                value: selectedGroupId,
                items: widget.groups.map((GroupEntity group) {
                  return DropdownMenuItem<String>(
                    value: group.uid,
                    child: Text(group.name ?? "Unnamed Group"),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedGroupId = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 40),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Save Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: matcronPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: selectedGroupId == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransferDonePage(),
                            ),
                          );
                        },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


