import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/features/organization/presentation/pages/organizations.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/resources/data_state.dart';

class OrganizationFormPage extends StatefulWidget {
  const OrganizationFormPage({super.key});

  @override
  OrganizationFormPageState createState() => OrganizationFormPageState();
}

class OrganizationFormPageState extends State<OrganizationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final OrganizationRepository _organizationRepository =
      GetIt.instance<OrganizationRepository>();

  String? _industryValue;

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _addressLine3Controller = TextEditingController();
  final TextEditingController _eirCodeController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _registrationController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _addressLine3Controller.dispose();
    _eirCodeController.dispose();
    _countyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  int _countWords(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  void _onAddOrganizationPressed() async {
    final theme = Theme.of(context);
    if (_formKey.currentState!.validate()) {
      OrganizationEntity entity = OrganizationEntity(
          name: _nameController.text,
          email: _emailController.text,
          description: _descriptionController.text,
          eirCode: _eirCodeController.text,
          county: _countyController.text,
          postalAddress: _addressLine1Controller.text,
          normalAddress: _addressLine2Controller.text,
          //type: _industryValue
          type: 1
          );

      var state = await _organizationRepository.addOrganization(entity);

      if (state is DataSuccess) {
        // Add delay before navigating
        await Future.delayed(Duration(milliseconds: 100));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  sl<RemoteOrganizationBloc>()..add(GetOrganizations()),
              child: const OrganizationPage(),
            ),
          ),
        );
      } else {
        // Display error notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add organization. Please try again.'),
            backgroundColor: theme.colorScheme.error,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.cardColor;
    final fieldColor = theme.colorScheme.surface;
    final primaryColor = theme.colorScheme.primary;
    final hintTextStyle = TextStyle(color: theme.colorScheme.shadow);
    final labelStyle =  TextStyle(fontSize: 16, color:theme.colorScheme.onSurface);

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            const Header(title: "Organisation"),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter organization name",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "E-Mail Address",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter an email address",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }

                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            // child: Container(
                            //   decoration: BoxDecoration(
                            //     color: fieldColor,
                            //     borderRadius: BorderRadius.circular(20.0),
                            //   ),
                            child: DropdownButtonFormField<String>(
                              value: _industryValue,
                              decoration: InputDecoration(
                                labelText: "Organisation",
                                labelStyle: labelStyle,
                                filled: true,
                                fillColor: fieldColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: <String>["Hospital", "Hotel"]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _industryValue = val;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Select Organisation";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _addressLine1Controller,
                        decoration: InputDecoration(
                          labelText: "Postal Address",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Postal Address",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _addressLine2Controller,
                        decoration: InputDecoration(
                          labelText: "Normal Address",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Normal Address",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _eirCodeController,
                              decoration: InputDecoration(
                                labelText: "EIR Code",
                                labelStyle: labelStyle,
                                filled: true,
                                fillColor: fieldColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter EIR Code",
                                hintStyle: hintTextStyle,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _countyController,
                              decoration: InputDecoration(
                                labelText: "County",
                                labelStyle: labelStyle,
                                filled: true,
                                fillColor: fieldColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter County",
                                hintStyle: hintTextStyle,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Description (Max: 100 words)",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter description",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                        validator: (value) {
                          if (value == null) return null;
                          final words = _countWords(value);
                          if (words > 100) {
                            return "Description cannot exceed 100 words";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onAddOrganizationPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                            ),
                          ),
                          child: Text(
                            "+Add Organisation",
                            style: TextStyle(color: theme.colorScheme.surface),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
