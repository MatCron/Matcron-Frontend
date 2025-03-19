import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';

class TransferOutMattressPage extends StatefulWidget {
  final List<GroupEntity> groups;
  final List<MattressEntity> mattresses;
  final Function(List<String>, String) addMattresses;

  TransferOutMattressPage(
      {super.key,
      required List<GroupEntity> groups,
      required this.mattresses,
      required this.addMattresses})
      : groups = _removeDuplicates(
            groups); // Filter duplicates before passing to state

  @override
  _TransferOutMattressPageState createState() =>
      _TransferOutMattressPageState();

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.cardColor,
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
                icon:  Icon(
                  Icons.close,
                  color: theme.colorScheme.error,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 40), // Adjust spacing

            // Title
             Text(
              "Add Mattresses To Group",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:  theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Dropdown for selecting group
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color:
                     theme.colorScheme.surface.withOpacity(0.8),
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
                    backgroundColor: theme.colorScheme.error,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      color:  theme.colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Save Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: selectedGroupId == null
                      ? null
                      : () {
                          widget.addMattresses(
                            widget.mattresses
                                .map((mattress) => mattress.uid)
                                .whereType<String>()
                                .toList(), // Extract only non-null IDs
                            selectedGroupId!,
                          );
                        },
                  child:  Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18,
                      color:  theme.colorScheme.surface,
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
