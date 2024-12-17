import 'package:flutter/material.dart';

class OrganizationFormPage extends StatefulWidget {
  const OrganizationFormPage({super.key});

  @override
  OrganizationFormPageState createState() => OrganizationFormPageState();
}

class OrganizationFormPageState extends State<OrganizationFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  String? _industryValue;
  bool _sameAsPostal = false;

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

  void _onAddOrganizationPressed() {
    if (_formKey.currentState!.validate()) {
       Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFE5E5E5);
    final fieldColor = Colors.white;
    final primaryColor = const Color(0xFF70A8A1); 
    final hintTextStyle = TextStyle(color: Colors.grey[600]);
    final labelStyle = const TextStyle(fontSize: 16, color: Colors.black54);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      "Organisation",
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ),
                  ),
                
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blueGrey[200],
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Stack(
                        children: [
                          Icon(Icons.notifications, color: Colors.blueGrey[400], size: 30),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                     
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: fieldColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _industryValue,
                                decoration: InputDecoration(
                                  labelText: "Industry",
                                  labelStyle: labelStyle,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                ),
                                icon: const Icon(Icons.arrow_drop_down),
                                items: <String>["Hospital", "Hotel", "IT", "Retail"].map((String value) {
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
                                    return "Select Industry";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _registrationController,
                              decoration: InputDecoration(
                                labelText: "Registration No.",
                                labelStyle: labelStyle,
                                filled: true,
                                fillColor: fieldColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Enter registration no.",
                                hintStyle: hintTextStyle,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

            
                      TextFormField(
                        controller: _addressLine1Controller,
                        decoration: InputDecoration(
                          labelText: "Address / Street",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Address line 1",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _addressLine2Controller,
                        decoration: InputDecoration(
                          labelText: "Address / Street",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Address line 2",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _addressLine3Controller,
                        decoration: InputDecoration(
                          labelText: "Address / Street",
                          labelStyle: labelStyle,
                          filled: true,
                          fillColor: fieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Address line 3",
                          hintStyle: hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 12),

          
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

         
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                      const SizedBox(height: 12),

                   
                      Row(
                        children: [
                          Checkbox(
                            value: _sameAsPostal,
                            onChanged: (val) {
                              setState(() {
                                _sameAsPostal = val ?? false;
                              });
                            },
                            activeColor: Colors.purple,
                          ),
                          const Text("Same as Postal Address")
                        ],
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
                          child: const Text(
                            "+Add Organisation",
                            style: TextStyle(color: Colors.white),
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
        ),
      ),
    );
  }
}
