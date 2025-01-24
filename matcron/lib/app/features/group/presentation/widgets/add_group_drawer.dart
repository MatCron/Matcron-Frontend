// import 'package:flutter/material.dart';

// class AddGroupDrawer extends StatelessWidget {
//   final TextEditingController nameController;
//   final String selectedOrganization;
//   final Function(String) onOrganizationChanged;
//   final TextEditingController descriptionController;
//   final List<String> organizations;

//   const AddGroupDrawer({
//     super.key,
//     required this.nameController,
//     required this.selectedOrganization,
//     required this.onOrganizationChanged,
//     required this.descriptionController,
//     required this.organizations,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Add New Group",
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close, color: Colors.grey),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 10.0),
//           // Name Field
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(
//               labelText: "Group Name",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           // Dropdown for Organization
//           DropdownButtonFormField<String>(
//             value: selectedOrganization.isEmpty ? organizations.first : selectedOrganization,
//             decoration: const InputDecoration(
//               labelText: "Select Organization",
//               border: OutlineInputBorder(),
//             ),
//             items: organizations.map((org) {
//               return DropdownMenuItem<String>(
//                 value: org,
//                 child: Text(org),
//               );
//             }).toList(),
//             onChanged: (value) {
//               if (value != null) {
//                 onOrganizationChanged(value);
//               }
//             },
//           ),
//           const SizedBox(height: 16.0),
//           // Description Field
//           TextField(
//             controller: descriptionController,
//             maxLines: 3,
//             decoration: const InputDecoration(
//               labelText: "Description",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16.0),
//           // Save Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle Save Logic
//                 Navigator.of(context).pop();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//               child: const Text("Save"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddGroupDrawer extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedOrganization;
  final Function(String) onOrganizationChanged;
  final String purposeController;
  final TextEditingController descriptionController;
  final List<String> organizations;

  const AddGroupDrawer({
    super.key,
    required this.nameController,
    required this.selectedOrganization,
    required this.onOrganizationChanged,
    required this.purposeController,
    required this.descriptionController,
    required this.organizations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add New Group",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Group Name Field
            _buildTextField(
              controller: nameController,
              labelText: "Group Name",
            ),
            const SizedBox(height: 16.0),

            // Organization Dropdown
            DropdownButtonFormField<String>(
              value: selectedOrganization.isEmpty ? organizations.first : selectedOrganization,
              decoration: _buildInputDecoration("Select Organization"),
              items: organizations.map((org) {
                return DropdownMenuItem<String>(
                  value: org,
                  child: Text(org),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onOrganizationChanged(value);
                }
              },
            ),
            const SizedBox(height: 16.0),

            // Purpose Dropdown
            DropdownButtonFormField<String>(
              value: purposeController.isEmpty ? "Maintenance" : purposeController,
              decoration: _buildInputDecoration("Select Purpose"),
              items: const [
                DropdownMenuItem(value: "Maintenance", child: Text("Maintenance")),
                DropdownMenuItem(value: "Emergency", child: Text("Emergency")),
                DropdownMenuItem(value: "End of Life Cycle", child: Text("End of Life Cycle")),
                DropdownMenuItem(value: "Shipping", child: Text("Shipping")),
              ],
              onChanged: (value) {
                if (value != null) {
                  // Update purposeController logic
                }
              },
            ),
            const SizedBox(height: 16.0),

            // Description Field
            _buildTextField(
              controller: descriptionController,
              labelText: "Description",
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Save Logic
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Save button color is green
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text is now black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields with a consistent style
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: _buildInputDecoration(labelText),
    );
  }

  // Helper method to create InputDecoration with consistent style
  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
