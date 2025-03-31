import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'dart:async';


class MattressBottomDrawer extends StatefulWidget {
  const MattressBottomDrawer(
      {super.key,
      required this.mattressTypes,
      required this.mattress,
      required this.userType,
      required this.onSave});
  final List<MattressTypeEntity> mattressTypes;
  final MattressEntity mattress;
  final int userType;
  final void Function(MattressEntity mattress) onSave;

  @override
  State<MattressBottomDrawer> createState() => MattressBottomDrawerState();
}

class MattressBottomDrawerState extends State<MattressBottomDrawer> {
  late MattressEntity mattress;
  late MattressRepository _mattressRepository;
  bool isLoading = true;
  late bool _isRotationDone =true;
late Duration _rotationTimer;
late Timer _timer;


  @override
  void initState() {
    super.initState();
    _mattressRepository = GetIt.instance<MattressRepository>();
   // Initialize with widget data first
  _isRotationDone = widget.mattress.rotationDone ?? false;
  _rotationTimer = const Duration(hours: 2); // Default
  _initializeMattress(); // Will update from fetched data

   // Initialize rotation timer (example: 12 hours)
  _rotationTimer = const Duration(hours: 2);
  _isRotationDone = widget.mattress.rotationDone ?? false;
  if (!_isRotationDone) {
    _startTimer();
  }
}

void _startTimer() {
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_rotationTimer.inSeconds > 0) {
      setState(() {
        _rotationTimer = _rotationTimer - const Duration(seconds: 1);
      });
    } else {
      timer.cancel();
      setState(() {}); // Force UI update for overdue state
    }
  });
}

@override
void dispose() {
  _timer.cancel();
  super.dispose();
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$hours:$minutes:$seconds';
}

void _markRotationDone() {
  setState(() {
    _isRotationDone = true;
    _timer.cancel();
    // Update the mattress entity
    mattress = mattress.copyWith(rotationDone: true);
  });
}

  void _initializeMattress() async {
    String id = widget.mattress.uid!;

    var state = await _mattressRepository.getMattressById(id);
    setState(() {
      if (state is DataSuccess) {
        mattress = state.data!;
        mattress.uid = id;
        mattress.mattressTypeId = mattress.mattressType!.id!;
         _isRotationDone = mattress.rotationDone ?? false;
          if (!_isRotationDone && _rotationTimer.inSeconds <= 0) {
        _rotationTimer = Duration.zero;
      }
      } else {
        mattress = widget.mattress;
      }
      isLoading = false; // Update loading state
    });
  }

  void _saveMattress(BuildContext context) {
      // Update rotation state in mattress
      mattress = mattress.copyWith(
    rotationDone: _isRotationDone,
    rotationTimer: _rotationTimer.inSeconds // If storing duration
  );
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
        final theme = Theme.of(context);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration:  BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
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
                    "Edit Mattress",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  // IconButton(
                  //   icon:  Icon(Icons.close, color:  theme.colorScheme.error),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                  
                    if (widget.userType == 1)
                    const SizedBox(height: 16),
                    
                    if (widget.userType == 1)
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
             Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Text(
          "Lateral Rotation",
          style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: _isRotationDone 
                  ? Colors.green
                  : _rotationTimer.inSeconds <= 0 
                      ? theme.colorScheme.error 
                      : theme.colorScheme.onSurface),
        ),
        const SizedBox(width: 5),
        Tooltip(
          message: _isRotationDone 
              ? 'Rotation completed'
              : 'Time remaining for next rotation',
          child: Icon(Icons.info_outline,
              size: 20, color: theme.colorScheme.shadow),
        ),
      ],
    ),
    ElevatedButton.icon(
      icon: Icon(
        _isRotationDone ? Icons.check_circle : Icons.rotate_left,
        color: theme.colorScheme.surface,
      ),
      label: Text(
        _isRotationDone 
            ? "Done"
            : _rotationTimer.inSeconds <= 0
                ? "Overdue!"
                : _formatDuration(_rotationTimer),
        style: TextStyle(
          color: theme.colorScheme.surface,
          fontWeight: FontWeight.bold
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isRotationDone 
            ? Colors.green
            : _rotationTimer.inSeconds <= 0
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: _isRotationDone ? null : () {
        _markRotationDone();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Rotation marked as completed!"),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      },
    ),
  ],
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
                        color:  theme.colorScheme.error,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        context,
                        label: "Save",
                        color: theme.colorScheme.primary,
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
        final theme = Theme.of(context);
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor:  theme.cardColor,
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
            // Get original index from mattressStatus
    final originalIndex = mattressStatus.indexWhere(
      (status) => status['Text'] == value
    );
    mattress = mattress.copyWith(status: originalIndex);
  });
        }
      },
      value: value,
    );
  }

  // Helper method for building text fields
  Widget _buildTextField(String label, String? value) {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor:  theme.cardColor,
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
        final theme = Theme.of(context);
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
          style:  TextStyle(color:  theme.colorScheme.surface, fontSize: 16)),
    );
  }
}
