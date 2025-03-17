import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';

class OrganizationBottomDrawer extends StatefulWidget {
  final OrganizationEntity organization;
  final bool isEditable;
  final void Function(OrganizationEntity organization) onSave;

  const OrganizationBottomDrawer({
    super.key,
    required this.organization,
    this.isEditable = false,
    required this.onSave,
  });

  @override
  OrganizationBottomDrawerState createState() =>
      OrganizationBottomDrawerState();
}

class OrganizationBottomDrawerState extends State<OrganizationBottomDrawer> {
  late OrganizationEntity organization;
  late OrganizationRepository _organizationRepository;
  bool isLoading = true; // Add loading state

  // Initialize organization with the passed entity
  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    _organizationRepository = GetIt.instance<OrganizationRepository>();
    _initializeOrganization();
  }

  void _initializeOrganization() async {
    String id = widget.organization.id!;

    var state = await _organizationRepository.getOrganization(id);
    setState(() {
      if (state is DataSuccess) {
        organization = state.data!;
      } else {
        organization = widget.organization;
      }
      isLoading = false; // Update loading state
    });
  }

  void _saveOrganization(BuildContext context) {
    // Validate and save organization entity data
    if (_validateFields()) {
      widget.onSave(organization); // Save the organization entity
      Navigator.of(context).pop(); // Close the drawer after saving
    }
  }

  // Validate the input fields
  bool _validateFields() {
    bool isValid = true;

    // Check for each field and validate manually
    if (organization.name == null || organization.name!.isEmpty) {
      isValid = false;
      _showErrorDialog('Organization name is required');
    }

    return isValid;
  }

  // Show an error dialog if validation fails
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
    final theme = Theme.of(context);
    if (isLoading) {
      //color matcronPrimaryColor
      return Center(child: CircularProgressIndicator(color:matcronPrimaryColor));
    }

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.6, // Opens at 3/5 screen height
      minChildSize: 0.4,
      maxChildSize: 1.0, // Allows for full-screen expansion
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration:  BoxDecoration(
            color:theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withOpacity(0.1),
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
                        ? "Edit Organization"
                        : "View Organization",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: matcronPrimaryColor,
                    ),
                  ),
                  IconButton(
                    icon:  Icon(Icons.close, color: theme.colorScheme.error),
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
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization = organization.copyWith(name: value);
                      }),
                    ),
                    const SizedBox(height: 20),
                    _buildDropdownField(
                      label: "Organization Type",
                      items: ["Hotel", "Hospital", "Other"],
                      initialValue: organization.type,
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization = organization.copyWith(type: value);
                      }),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Email",
                      initialValue: organization.email ?? '',
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization = organization.copyWith(email: value);
                      }),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Registration Number",
                      initialValue:
                          organization.registrationNumber?.toString() ?? '',
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization =
                            organization.copyWith(registrationNumber: value);
                      }),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Postal Address",
                      initialValue: organization.postalAddress ?? '',
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization =
                            organization.copyWith(postalAddress: value);
                      }),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: "Normal Address",
                      initialValue: organization.normalAddress ?? '',
                      enabled: widget.isEditable,
                      onChanged: (value) => setState(() {
                        organization =
                            organization.copyWith(normalAddress: value);
                      }),
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
                          color: theme.colorScheme.error,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          context,
                          label: "Save",
                          color: matcronPrimaryColor,
                          onPressed: () {
                            _saveOrganization(context);
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
    required ValueChanged<String> onChanged,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: enabled ? theme.cardColor :  theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      onChanged: onChanged,
    );
  }

  // Helper method for building dropdown fields
  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    String? initialValue,
    bool enabled = true,
    required ValueChanged<String> onChanged,
  }) {
    final theme = Theme.of(context);
    String? finalValue = initialValue;
    if (finalValue == null || !items.contains(finalValue)) {
      finalValue = "Other";
    }
    return DropdownButtonFormField<String>(
      value: finalValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: enabled ?  theme.cardColor :  theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: enabled ? (value) => onChanged(value ?? '') : null,
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
