import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';
import 'package:matcron/app/features/mattress_history/domain/repositories/mattress_history_repository.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';

class MattressTypeBottomDrawer extends StatefulWidget {
  final MattressTypeEntity mattress;
  final String? failSafe;
  final bool isEditable;
  final bool? showHistory;
  final void Function(MattressTypeEntity mattress) onSave;

  const MattressTypeBottomDrawer(
      {super.key,
      required this.mattress,
      this.isEditable = false,
      required this.onSave,
      this.failSafe,
      this.showHistory});

  @override
  MattressTypeBottomDrawerState createState() =>
      MattressTypeBottomDrawerState();
}

class MattressTypeBottomDrawerState extends State<MattressTypeBottomDrawer> {
  late MattressTypeEntity mattress;
  late TypeRepository _typeRepository;
  late MattressRepository _mattressRepository;
  late MattressHistoryRepository _mattressHistoryRepository;
  late List<MattressHistoryEntity> history;

  bool isLoading = true;
  int currentTab = 0;
  //0 == DPP Info
  //1 = History

  @override
  void initState() {
    super.initState();
    mattress = widget.mattress;
    _mattressRepository = GetIt.instance<MattressRepository>();
    _typeRepository = GetIt.instance<TypeRepository>();
    _mattressHistoryRepository = GetIt.instance<MattressHistoryRepository>();
    _initializeMattress();
  }

  List<MattressHistoryEntity> sortByNewest(List<MattressHistoryEntity> list) {
    list.sort((a, b) =>
        (b.timeStamp ?? DateTime(0)).compareTo(a.timeStamp ?? DateTime(0)));
    return list;
  }

  void _initializeMattress() async {
    String id = "";
    if (mattress.id == null) {
      var state = await _mattressRepository.getMattressById(widget.failSafe!);
      var historyState = await _mattressHistoryRepository
          .getMattressHistoryById(widget.failSafe!);

      if (state is DataSuccess && state.data != null) {
        setState(() {
          mattress = state.data!.mattressType!;
          history = sortByNewest(historyState.data!);
          id = mattress.id!;
        });
      }
    } else {
      id = mattress.id!;
    }

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

  void _saveType(BuildContext context) {
    if (_validateFields()) {
      //print(mattress.name);
      widget.onSave(mattress);
      Navigator.of(context).pop();
    }
  }

  bool _validateFields() {
    bool isValid = true;
    if (mattress.name == null || mattress.name!.isEmpty) {
      isValid = false;
      _showErrorDialog('Name is required');
    }
    return isValid;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                  widget.showHistory != null && widget.showHistory != false
                      ? Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentTab = 0;
                                  });
                                },
                                child: Text(
                                  "DPP Info",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: matcronPrimaryColor,
                                    decoration: currentTab == 0
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationColor: matcronPrimaryColor,
                                    decorationThickness: 2.0,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentTab = 1;
                                  });
                                },
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: matcronPrimaryColor,
                                    decoration: currentTab == 1
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationColor: matcronPrimaryColor,
                                    decorationThickness: 2.0,
                                  ),
                                )),
                          ],
                        )
                      : Text(
                          widget.isEditable
                              ? "Edit Mattress Details"
                              : "View Mattress Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: matcronPrimaryColor,
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

              if (widget.showHistory == true && currentTab == 1)
                Expanded(
                  child: Column(
                    children: [
                      // Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Details",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),

                      // List of history items
                      Expanded(
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final item = history[index];
                            bool isLast = index ==
                                history.length -
                                    1; // Check if it's the last item

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Timeline Indicator (Dot + Line)
                                  Column(
                                    children: [
                                      // Dot
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: matcronPrimaryColor, // Customize color
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Vertical Line
                                      if (!isLast)
                                        Container(
                                          width: 2,
                                          height: 40, // Adjust for spacing
                                          color: const Color.fromARGB(255, 80, 194, 201).withOpacity(0.5),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                      width:
                                          12), // Space between timeline and text

                                  // Details & Timestamp
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.details ?? "No details",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.timeStamp != null
                                              ? "${item.timeStamp!.day}/${item.timeStamp!.month}/${item.timeStamp!.year}"
                                              : "No date",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              if (widget.showHistory == null ||
                  widget.showHistory == false ||
                  currentTab == 0)
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
                                onChanged: (value) {
                                  setState(() {
                                    mattress.name = value;
                                  });
                                }),
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
                                onChanged: (value) {
                                  setState(() {
                                    mattress.width = value as double?;
                                  });
                                }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                                label: "Length (cm)",
                                initialValue: mattress.length?.toString() ?? '',
                                enabled: widget.isEditable,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    mattress.length = value as double?;
                                  });
                                }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                                label: "Height (cm)",
                                initialValue: mattress.height?.toString() ?? '',
                                enabled: widget.isEditable,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    mattress.height = value as double?;
                                  });
                                }),
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
                          onChanged: (value) {
                            setState(() {
                              mattress.composition = value;
                            });
                          }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: _buildTextField(
                                  label: "Rotation Interval (MM)",
                                  initialValue:
                                      mattress.rotationInterval?.toString() ??
                                          '',
                                  enabled: widget.isEditable,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      mattress.rotationInterval =
                                          value as double?;
                                    });
                                  })),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                                label: "Expected Lifespan (YYYY)",
                                initialValue:
                                    mattress.expectedLifespan?.toString() ?? '',
                                enabled: widget.isEditable,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    mattress.expectedLifespan =
                                        value as double?;
                                  });
                                }),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                          label: "Warranty Period",
                          initialValue:
                              mattress.warrantyPeriod?.toString() ?? '',
                          enabled: widget.isEditable,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              mattress.warrantyPeriod = value as double?;
                            });
                          }),
                      const SizedBox(height: 20),
                      _buildTextField(
                          label: "Recycling Details",
                          initialValue: mattress.recyclingDetails ?? '',
                          enabled: widget.isEditable,
                          onChanged: (value) {
                            setState(() {
                              mattress.recyclingDetails = value;
                            });
                          }),
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
                          color: matcronPrimaryColor,
                          onPressed: () {
                            _saveType(context);
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
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
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
