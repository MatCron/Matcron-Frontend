// import 'package:flutter/material.dart';
// import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
// import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';

// class TransferOutMattressPage extends StatefulWidget {
//   final List<GroupEntity> groups;
//   final List<MattressEntity> mattresses;
//   final Function(List<String>, String) addMattresses;

//   TransferOutMattressPage({
//     super.key,
//     required List<GroupEntity> groups,
//     required this.mattresses,
//     required this.addMattresses,
//   }) : groups = _removeDuplicates(groups);

//   @override
//   _TransferOutMattressPageState createState() => _TransferOutMattressPageState();

//   static List<GroupEntity> _removeDuplicates(List<GroupEntity> groups) {
//     final seen = <String>{};
//     return groups.where((group) {
//       if (group.uid == null || seen.contains(group.uid)) {
//         return false;
//       }
//       seen.add(group.uid!);
//       return true;
//     }).toList();
//   }
// }

// class _TransferOutMattressPageState extends State<TransferOutMattressPage> {
//   String? selectedGroupId;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start, // Move items up
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // **Close Button**
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: theme.colorScheme.error, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),

//             // **GIF as a Static Image with Background (Larger Size)**
//             Container(
//               width: double.infinity,
//               height: 180, // Increased height
//               padding: const EdgeInsets.all(16), // More padding
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.primary,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/grouping.gif', // Ensure this path is correct
//                   height: 150, // Increased size
//                   width: 150,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20), // Reduced spacing

//             // **Title**
//             Text(
//               "Add Mattresses To Group",
//               style: TextStyle(
//                 fontSize: 26, // Slightly bigger text
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.primary,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 20),

//             // **Dropdown for selecting a group**
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.surface.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               child: DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(border: InputBorder.none),
//                 hint: const Text("Select Group"),
//                 value: selectedGroupId,
//                 items: widget.groups.map((GroupEntity group) {
//                   return DropdownMenuItem<String>(
//                     value: group.uid,
//                     child: Text(group.name ?? "Unnamed Group"),
//                   );
//                 }).toList(),
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedGroupId = value;
//                   });
//                 },
//               ),
//             ),

//             const SizedBox(height: 30),

//             // **Buttons Row**
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // **Cancel Button**
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: theme.colorScheme.error,
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: theme.colorScheme.surface,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 // **Save Button**
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: selectedGroupId == null ? theme.disabledColor : theme.colorScheme.primary,
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   onPressed: selectedGroupId == null
//                       ? null
//                       : () {
//                           widget.addMattresses(
//                             widget.mattresses
//                                 .map((mattress) => mattress.uid)
//                                 .whereType<String>()
//                                 .toList(),
//                             selectedGroupId!,
//                           );
//                         },
//                   child: Text(
//                     "Save",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: theme.colorScheme.surface,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';

class TransferOutMattressPage extends StatefulWidget {
  final List<GroupEntity> groups;
  final List<MattressEntity> mattresses;
  final Function(List<String>, String) addMattresses;

  TransferOutMattressPage({
    super.key,
    required List<GroupEntity> groups,
    required this.mattresses,
    required this.addMattresses,
  }) : groups = _removeDuplicates(groups);

  @override
  _TransferOutMattressPageState createState() => _TransferOutMattressPageState();

  static List<GroupEntity> _removeDuplicates(List<GroupEntity> groups) {
    final seen = <String>{};
    return groups.where((group) {
      if (group.uid == null || seen.contains(group.uid)) {
        return false;
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
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child:  Icon(Icons.arrow_back, color: theme.colorScheme.surface),
            ),
          ),
        ),
        title: Text(
          "Add Mattresses To Group",
          style: TextStyle(
            color: theme.colorScheme.surface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/grouping.gif',
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Dropdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select Group"),
                  value: selectedGroupId,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selectedGroupId = value;
                    });
                  },
                  items: widget.groups.map((GroupEntity group) {
                    return DropdownMenuItem<String>(
                      value: group.uid,
                      child: Text(group.name ?? "Unnamed Group"),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Cancel",
                      style: TextStyle(
                          color: theme.colorScheme.error,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),

                // Save Button
                ElevatedButton(
                  onPressed: selectedGroupId == null
                      ? null
                      : () {
                          widget.addMattresses(
                            widget.mattresses
                                .map((mattress) => mattress.uid)
                                .whereType<String>()
                                .toList(),
                            selectedGroupId!,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedGroupId == null
                        ? theme.disabledColor
                        : theme.cardColor,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Save",
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
