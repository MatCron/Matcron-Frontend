// lib/ui/components/bottom_drawer.dart
import 'package:flutter/material.dart';

class MattressBottomDrawer extends StatelessWidget {
  const MattressBottomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.55, // Opens at 3/4 screen height
      minChildSize: 0.55,
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
                  const Text(
                    "Edit Mattress",
                    style: TextStyle(
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
                    _buildDropdownField(
                      label: "Edit Mattress Type",
                      items: [
                        "Single (12 x 34 x 50)",
                        "Double (13 x 39 x 60)",
                        "King (13 x 39 x 60)",
                        "Add Custom Type"
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField("Room Number"),
                    const SizedBox(height: 20),
                    _buildDropdownField(
                      label: "Status",
                      items: ["Available", "Occupied", "Maintenance"],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Lateral Rotation Done?",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Tooltip(
                              message: 'Indicates if the lateral rotation has been completed',
                              child: Icon(Icons.info_outline, size: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle, color: Colors.green, size: 40),
                          onPressed: () {
                            // Action for lateral rotation done
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Buttons aligned to the bottom right
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
                          // Save action
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

  // Helper method for building dropdown fields
  Widget _buildDropdownField({required String label, required List<String> items}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: Colors.grey[200],
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
      onChanged: (value) {
        // Handle dropdown selection
      },
    );
  }

  // Helper method for building text fields
  Widget _buildTextField(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  // Helper method for building action buttons
  Widget _buildActionButton(BuildContext context, {required String label, required Color color, required VoidCallback onPressed}) {
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
