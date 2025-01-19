import 'package:flutter/material.dart';

class AddGroupDrawer extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedOrganization;
  final Function(String) onOrganizationChanged;
  final TextEditingController descriptionController;
  final List<String> organizations;

  const AddGroupDrawer({
    super.key,
    required this.nameController,
    required this.selectedOrganization,
    required this.onOrganizationChanged,
    required this.descriptionController,
    required this.organizations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
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
          // Name Field
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Group Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          // Dropdown for Organization
          DropdownButtonFormField<String>(
            value: selectedOrganization.isEmpty ? organizations.first : selectedOrganization,
            decoration: const InputDecoration(
              labelText: "Select Organization",
              border: OutlineInputBorder(),
            ),
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
          // Description Field
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
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
                backgroundColor: Colors.blue,
              ),
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
