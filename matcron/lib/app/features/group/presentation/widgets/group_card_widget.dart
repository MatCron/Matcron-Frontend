// import 'package:flutter/material.dart';

// class GroupCardWidget extends StatelessWidget {
//   final String groupName;
//   final String description;
//   final bool isActive;
//   final VoidCallback? onTap;

//   const GroupCardWidget({
//     super.key,
//     required this.groupName,
//     required this.description,
//     required this.isActive,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         color: Colors.white,
//         elevation: 3,
//         child: ListTile(
//           title: Text(
//             groupName,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(description),
//           trailing: Text(
//             isActive ? "Active" : "Archived",
//             style: TextStyle(
//               color: isActive ? Colors.green : Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class GroupCardWidget extends StatelessWidget {
  final String groupName;
  final String organisationName;
  final int mattressCount;
  final bool isExport;
  final VoidCallback? onTap;

  const GroupCardWidget({
    super.key,
    required this.groupName,
    required this.organisationName,
    required this.mattressCount,
    required this.isExport,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Group Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "$mattressCount mattresses",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Organisation Info with Icon
              Row(
                children: [
                  Image.asset(
                    isExport
                        ? "assets/images/exportIcon.png"
                        : "assets/images/importIcon.png",
                    height: 24.0,
                    width: 24.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    organisationName,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
