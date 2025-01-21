import 'package:flutter/material.dart';
import 'package:matcron/app/features/LBH_info/presentation/bloc/pages/lbh_info.dart';
import 'package:matcron/app/features/recycling_info/presentation/recycling_info.dart';
import 'package:matcron/core/components/header/header.dart'; // Adjust import as needed

class AddMattressTypePage extends StatefulWidget {
  const AddMattressTypePage({
    super.key,
  });

  @override
  AddMattressTypePageState createState() => AddMattressTypePageState();
}

class AddMattressTypePageState extends State<AddMattressTypePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController _typeNameController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _materialCompositionController =
      TextEditingController();
  final TextEditingController _allergenInfoController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _recycleInfoController = TextEditingController();
  final TextEditingController _rotationTimerController =
      TextEditingController();

  String? _lifeSpanValue;
  String? _washableValue;

  @override
  void dispose() {
    _typeNameController.dispose();
    _widthController.dispose();
    _lengthController.dispose();
    _heightController.dispose();
    _materialCompositionController.dispose();
    _allergenInfoController.dispose();
    _manufacturerController.dispose();
    _recycleInfoController.dispose();
    _rotationTimerController.dispose();
    super.dispose();
  }

  int _countWords(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  void _onAddMattressTypePressed() {
    if (_formKey.currentState!.validate()) {
      // MattressTypeEntity entity = MattressTypeEntity(
      //   name: _typeNameController.text.trim(),
      //   width: double.tryParse(_widthController.text.trim()),
      //   length: double.tryParse(_lengthController.text.trim()),
      //   height: double.tryParse(_heightController.text.trim()),
      //   composition: _materialCompositionController.text.trim(),
      //   rotationInterval: double.tryParse(_rotationTimerController.text.trim()),
      //   recyclingDetails: _recycleInfoController.text.trim(),
      //   expectedLifespan: _lifeSpanValue != null
      //       ? double.tryParse(_lifeSpanValue!.split(' ').first)
      //       : null,
      //   warrantyPeriod: _washableValue == "Yes" ? 1.0 : 0.0, // Example
      // );

    }

  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFE5E5E5);
    final fieldColor = Colors.white;
    final primaryColor = const Color.fromARGB(255, 80, 194, 201);
    final hintTextStyle = TextStyle(color: Colors.grey[600]);
    const labelStyle = TextStyle(fontSize: 16, color: Colors.black54);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const Header(title: "Mattress Type"),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type Name
                    TextFormField(
                      controller: _typeNameController,
                      decoration: InputDecoration(
                        labelText: "Type Name",
                        labelStyle: labelStyle,
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Enter mattress type name",
                        hintStyle: hintTextStyle,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a type name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Width x Length x Height with an info icon to the right
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _widthController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: "Width",
                              labelStyle: labelStyle,
                              filled: true,
                              fillColor: fieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Width",
                              hintStyle: hintTextStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text("x", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _lengthController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: "Length",
                              labelStyle: labelStyle,
                              filled: true,
                              fillColor: fieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Length",
                              hintStyle: hintTextStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text("x", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _heightController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: "Height",
                              labelStyle: labelStyle,
                              filled: true,
                              fillColor: fieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Height",
                              hintStyle: hintTextStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Info icon
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MattressDimensionsPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: fieldColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: const Icon(Icons.info_outline,
                                size: 20, color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Material Composition (max 100 words)
                    TextFormField(
                      controller: _materialCompositionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Material Composition",
                        labelStyle: labelStyle,
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Enter material composition",
                        hintStyle: hintTextStyle,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        // Display max 100 words note
                        suffixText: "(Max: 100 word)",
                        suffixStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      validator: (value) {
                        if (value == null) return null;
                        if (_countWords(value) > 100) {
                          return "Description cannot exceed 100 words";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Manufacturer and Life Span (dropdown)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: _lifeSpanValue,
                            decoration: InputDecoration(
                              labelText: "Life Span",
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
                            items: <String>[
                              "1 year",
                              "2 years",
                              "5 years",
                              "10 years"
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _lifeSpanValue = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Recycle Information (max 100 words) + info icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _recycleInfoController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Recycle Information",
                              labelStyle: labelStyle,
                              filled: true,
                              fillColor: fieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter recycle information",
                              hintStyle: hintTextStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              suffixText: "(Max: 100 word)",
                              suffixStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                            validator: (value) {
                              if (value == null) return null;
                              if (_countWords(value) > 100) {
                                return "Description cannot exceed 100 words";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Info icon for recycle info
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MattressRecyclingInfoPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: fieldColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.only(top: 8),
                            child: const Icon(Icons.info_outline,
                                size: 20, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Rotation Timer + clock icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _rotationTimerController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            decoration: InputDecoration(
                              labelText: "Rotation Timer",
                              labelStyle: labelStyle,
                              filled: true,
                              fillColor: fieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter rotation timer",
                              hintStyle: hintTextStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Clock icon button
                        Container(
                          decoration: BoxDecoration(
                            color: fieldColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.access_time_outlined,
                              size: 20, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Washable dropdown
                    DropdownButtonFormField<String>(
                      value: _washableValue,
                      decoration: InputDecoration(
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
                      hint: const Text("washable", style: labelStyle),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: <String>["Yes", "No"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _washableValue = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Add Mattress Type button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onAddMattressTypePressed,
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
                          "+ Add Mattress Type",
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
    );
  }
}
