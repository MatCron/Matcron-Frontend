import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';

class MattressTypeBottomDrawer extends StatefulWidget {
  final MattressTypeEntity mattress;
  final bool isEditable;
  final void Function(MattressTypeEntity mattress) onSave;

  const MattressTypeBottomDrawer({
    super.key,
    required this.mattress,
    this.isEditable = false,
    required this.onSave,
  });

  @override
  MattressTypeBottomDrawerState createState() =>
      MattressTypeBottomDrawerState();
}

class MattressTypeBottomDrawerState extends State<MattressTypeBottomDrawer> {
  late MattressTypeEntity mattress;
  late TypeRepository _typeRepository;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    mattress = widget.mattress;
    _typeRepository = GetIt.instance<TypeRepository>();
    _initializeMattress();
  }

  void _initializeMattress() async {
    String id = mattress.id!;

    var state = await _typeRepository.getType(id);
    setState(() {
      if (state is DataSuccess) {
        mattress = state.data!;
      } else {
        mattress = widget.mattress;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      //color matcronPrimaryColor
      return Center(
          child: CircularProgressIndicator(color: matcronPrimaryColor));
    }

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 1.0,
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
                    widget.isEditable
                        ? "Edit Mattress Details"
                        : "View Mattress Details",
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
                    // Mattress Name and Expected Lifespan in one row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Mattress Name",
                            initialValue: mattress.name ?? '',
                            enabled: widget.isEditable,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Length, Width, Height in one row with Info Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Width (cm)",
                            initialValue: mattress.width?.toString() ?? '',
                            enabled: widget.isEditable,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: "Length (cm)",
                            initialValue: mattress.length?.toString() ?? '',
                            enabled: widget.isEditable,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: "Height (cm)",
                            initialValue: mattress.height?.toString() ?? '',
                            enabled: widget.isEditable,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Composition with multiline input
                    _buildTextField(
                      label: "Composition",
                      initialValue: mattress.composition ?? '',
                      enabled: widget.isEditable,
                      maxLines: null, // Allow multiline
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: _buildTextField(
                          label: "Rotation Interval (MM)",
                          initialValue:
                              mattress.rotationInterval?.toString() ?? '',
                          enabled: widget.isEditable,
                          keyboardType: TextInputType.number,
                        )),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: "Expected Lifespan (YYYY)",
                            initialValue:
                                mattress.expectedLifespan?.toString() ?? '',
                            enabled: widget.isEditable,
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Warranty Period",
                      initialValue: mattress.warrantyPeriod?.toString() ?? '',
                      enabled: widget.isEditable,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Recycling Details",
                      initialValue: mattress.recyclingDetails ?? '',
                      enabled: widget.isEditable,
                    ),
                  ],
                ),
              ),
              if (widget.isEditable)
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
    TextInputType keyboardType = TextInputType.text,
    int? maxLines,
  }) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: enabled ? Colors.grey[200] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
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
