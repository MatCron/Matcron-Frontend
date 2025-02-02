import 'package:flutter/material.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/authorization.dart';

class AddGroupDrawer extends StatefulWidget {
  final TextEditingController nameController;
  final String selectedOrganization;
  final Function(String) onOrganizationChanged;
  final Function(CreateGroupModel) onSave;
  final TextEditingController purposeController;
  final TextEditingController descriptionController;
  final List<OrganizationEntity> organizations;

  const AddGroupDrawer({
    super.key,
    required this.nameController,
    required this.selectedOrganization,
    required this.onOrganizationChanged,
    required this.purposeController,
    required this.descriptionController,
    required this.organizations,
    required this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddGroupDrawerState createState() => _AddGroupDrawerState();
}

class _AddGroupDrawerState extends State<AddGroupDrawer> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late String _selectedOrganization;
  late String _selectedPurpose;
  final AuthorizationService _authService = AuthorizationService();
  String? _senderOrgId;
  bool _loading = true; // Tracks if senderOrgId is still loading

  @override
  void initState() {
    super.initState();
    _nameController = widget.nameController;
    _descriptionController = widget.descriptionController;
    _selectedOrganization = widget.selectedOrganization;
    _selectedPurpose = widget.purposeController.text.isEmpty ? "Maintenance" : widget.purposeController.text;

    _fetchSenderOrgId(); // Fetch sender org ID from token
  }

  /// Fetch sender organization ID from token
  Future<void> _fetchSenderOrgId() async {
    var tokenDetails = await _authService.getTokenDetails();
    if (tokenDetails != null && tokenDetails.containsKey("OrgId")) {
      setState(() {
        _senderOrgId = tokenDetails["OrgId"];
        _loading = false; // Stop loading once ID is fetched
      });
    } else {
      setState(() {
        _loading = false; // Stop loading even if ID is not found
      });
    }
  }

  void _saveGroup() {
    if (_senderOrgId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sender Organization ID not found!")),
      );
      return;
    }

    final group = CreateGroupModel(
      name: _nameController.text,
      description: _descriptionController.text,
      receiverOrgId: _selectedOrganization,
      senderOrgId: _senderOrgId!, // Use dynamic senderOrgId from token
      transferOutPurpose: _getPurposeId(_selectedPurpose),
    );

    widget.onSave(group);
    Navigator.of(context).pop();
  }

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
      child: _loading
          ? const Center(child: CircularProgressIndicator()) // Show loader while fetching ID
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  _buildTextField(
                    controller: _nameController,
                    labelText: "Group Name",
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedOrganization.isEmpty ? null : _selectedOrganization,
                    decoration: _buildInputDecoration("Select Organization"),
                    items: widget.organizations.map((org) {
                      return DropdownMenuItem<String>(
                        value: org.id,
                        child: Text(org.name ?? "Unknown"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedOrganization = value;
                        });
                        widget.onOrganizationChanged(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedPurpose,
                    decoration: _buildInputDecoration("Select Purpose"),
                    items: const [
                      DropdownMenuItem(value: "Maintenance", child: Text("Maintenance")),
                      DropdownMenuItem(value: "Emergency", child: Text("Emergency")),
                      DropdownMenuItem(value: "End of Life Cycle", child: Text("End of Life Cycle")),
                      DropdownMenuItem(value: "Shipping", child: Text("Shipping")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedPurpose = value;
                        });
                        widget.purposeController.text = value;
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                    controller: _descriptionController,
                    labelText: "Description",
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _senderOrgId == null ? null : _saveGroup, // Disable if ID is not loaded
                      style: ElevatedButton.styleFrom(
                        backgroundColor: matcronPrimaryColor,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

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

  int _getPurposeId(String purpose) {
    switch (purpose) {
      case "Maintenance":
        return 1;
      case "Emergency":
        return 2;
      case "End of Life Cycle":
        return 3;
      case "Shipping":
        return 4;
      default:
        return 0;
    }
  }
}