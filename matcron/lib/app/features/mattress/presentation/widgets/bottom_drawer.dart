import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';

class MattressBottomDrawer extends StatefulWidget {
  const MattressBottomDrawer(
      {super.key,
      required this.mattressTypes,
      required this.mattress,
      required this.onSave});
  final List<MattressTypeEntity> mattressTypes;
  final MattressEntity mattress;
  final void Function(MattressEntity mattress) onSave;

  @override
  State<MattressBottomDrawer> createState() => MattressBottomDrawerState();
}

class MattressBottomDrawerState extends State<MattressBottomDrawer> {
  late MattressEntity mattress;
  late MattressRepository _mattressRepository;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mattressRepository = GetIt.instance<MattressRepository>();
    _initializeMattress();
  }

  void _initializeMattress() async {
    String id = widget.mattress.uid!;

    var state = await _mattressRepository.getMattressById(id);
    setState(() {
      if (state is DataSuccess) {
        mattress = state.data!;
        mattress.uid = id;
        mattress.mattressTypeId = mattress.mattressType!.id!;
      } else {
        mattress = widget.mattress;
      }
      isLoading = false; // Update loading state
    });
  }

  void _saveMattress(BuildContext context) {
    //validation lator,
    widget.onSave(mattress);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Remove duplicate mattress types using a Set
    List<String> uniqueMattressTypes = _getUniqueMattressTypes();

    if (isLoading) {
      //color matcronPrimaryColor
      return Center(
          child: CircularProgressIndicator(color: matcronPrimaryColor));
    }

    return DraggableScrollableSheet(
      expand: false, // Keeps the sheet from auto-expanding too much
      initialChildSize: 1, // Opens at ~55% of screen height
      minChildSize: 0.55, // Minimum height, keeping it from collapsing too much
      maxChildSize: 1.0, // Full-screen expansion
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
              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 16),
                    _buildDropdownField(
                        label: "Edit Mattress Type",
                        items: uniqueMattressTypes, // Pass the unique types
                        value: mattress.mattressType?.name,
                        purpose: "TYPE"),
                    const SizedBox(height: 20),
                    _buildTextField("Mattress Location", mattress.location),
                    const SizedBox(height: 20),
                    _buildDropdownField(
                        label: "Status",
                        items: _getUniqueStatus(), // Pass the unique status
                        value:
                            mattressStatus[mattress.status!]['Text'] as String,
                        purpose: "STATUS"),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Lateral Rotation Done?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Tooltip(
                              message:
                                  'Indicates if the lateral rotation has been completed',
                              child: Icon(Icons.info_outline,
                                  size: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green, size: 40),
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
                          _saveMattress(context);
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

  

  // Helper method to remove duplicates and get unique mattress types
  List<String> _getUniqueMattressTypes() {
    // Create a set from the mattress types to remove duplicates
    final Set<String> uniqueTypes = {
      ...widget.mattressTypes
          .map((type) => type.name ?? 'Unknown') // Map and remove duplicates
    };
    return uniqueTypes.toList();
  }

//   const mattressStatus = [
//   {"Text": "In Production", "Color": Colors.orange},
//   {"Text": "In Inventory", "Color": Colors.green},
//   {"Text": "Assigned", "Color": Colors.green},
//   {"Text": "In Use", "Color": Colors.green},
//   {"Text": "Cleaning Required", "Color": Colors.red},
//   {"Text": "Decommissioned", "Color": Colors.red},
// ];

  List<String> _getUniqueStatus() {
    final Set<String> uniqueStatus = {
      ...mattressStatus.map((status) => status['Text'] as String? ?? 'Unknown')
    };
    return uniqueStatus.toList();
  }

  // Helper method for building dropdown fields
  Widget _buildDropdownField(
      {required String label,
      required List<String> items,
      String? value,
      required purpose}) {
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        if (purpose == "TYPE") {
        setState(() {
          final selectedType = widget.mattressTypes.firstWhere(
            (type) => type.name == value,
            orElse: () => MattressTypeEntity(id: null, name: null),
          );
          mattress = mattress.copyWith(mattressTypeId: selectedType.id);
        });
      }

        if (purpose == "STATUS") {
          setState(() {
            mattress =
                mattress.copyWith(status: _getUniqueStatus().indexOf(value!));
          });
        }
      },
      value: value,
    );
  }

  // Helper method for building text fields
  Widget _buildTextField(String label, String? value) {
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      initialValue: value,
      onChanged: (value) => setState(() {
        mattress = mattress.copyWith(location: value);
      }),
    );
  }

  // Helper method for building action buttons
  Widget _buildActionButton(BuildContext context,
      {required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
