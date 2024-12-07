import 'package:flutter/material.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';

class OrganizationBottomDrawer extends StatelessWidget {
  final OrganizationEntity organization;
  final bool isEditable;

  const OrganizationBottomDrawer({
    super.key,
    required this.organization,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.6, // Opens at 3/5 screen height
      minChildSize: 0.4,
      maxChildSize: 1.0, // Allows for full-screen expansion
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditable ? "Edit Organization" : "View Organization",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Organization Name",
                      initialValue: organization.name ?? '',
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildDropdownField(
                      label: "Organization Type",
                      items: ["Hotel", "Hospital", "Other"],
                      initialValue: organization.type,
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Email",
                      initialValue: organization.email ?? '',
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Registration Number",
                      initialValue:
                          organization.registrationNumber?.toString() ?? '',
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Address",
                      initialValue: organization.address ?? '',
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Eir Code",
                      initialValue: organization.eirCode ?? '',
                      enabled: isEditable,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "County",
                      initialValue: organization.county ?? '',
                      enabled: isEditable,
                    ),
                  ],
                ),
              ),
              if (isEditable)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionButton(
                          context,
                          label: "Cancel",
                          color: Colors.red,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          context,
                          label: "Save",
                          color: Colors.teal,
                          onPressed: () {
                            // Save action placeholder
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Helper method for building text fields
  Widget _buildTextField({
    required String label,
    required String initialValue,
    bool enabled = true,
  }) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: enabled ? Colors.grey[200] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  // Helper method for building dropdown fields
  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    String? initialValue,
    bool enabled = true,
  }) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: enabled ? Colors.grey[200] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: enabled ? (value) {} : null,
    );
  }

  // Helper method for building action buttons
  Widget _buildActionButton(BuildContext context,
      {required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
