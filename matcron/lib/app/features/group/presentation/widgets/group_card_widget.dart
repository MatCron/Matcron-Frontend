
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
                        ? "assets/images/importIcon.png"
                        : "assets/images/exportIcon.png",
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


// import 'package:flutter/material.dart';
// import '../../domain/entities/group_entity.dart';

// class GroupCardWidget extends StatelessWidget {
//   final GroupEntity group;
//   final VoidCallback? onTap;

//   const GroupCardWidget({
//     Key? key,
//     required this.group,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // isExport or not: you can decide based on group.transferOutPurpose or something
//     final bool isExport = (group.transferOutPurpose ?? 0) > 0;

//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 3,
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               // Left side: Group info
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     group.name,
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "${group.mattressCount} mattresses",
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               // Right side: Possibly an export/import icon
//               Row(
//                 children: [
//                   Icon(
//                     isExport ? Icons.upload_file : Icons.download,
//                     color: isExport ? Colors.orange : Colors.green,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     group.receiverOrganisationName ?? "No receiver",
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
