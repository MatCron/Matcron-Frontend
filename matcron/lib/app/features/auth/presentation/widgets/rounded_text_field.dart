import 'package:flutter/material.dart';
import 'package:matcron/core/constants/constants.dart';

class RoundedTextField extends StatefulWidget {
  final String placeholder;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? autofillHint; // New property for autofill hints

  const RoundedTextField({
    super.key,
    required this.placeholder,
    required this.inputType,
    required this.controller,
    this.autofillHint, // Allow null for optional autofill
  });

  @override
  RoundedTextFieldState createState() => RoundedTextFieldState();
}

class RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscureText = true; // Default to obscured text for password fields

  // This checks if the input type is a password, enabling or disabling obscure text
  bool get _shouldObscureText {
    return widget.inputType == TextInputType.visiblePassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the visibility of the password
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: widget.controller, // Attach the provided controller
        obscureText: _shouldObscureText ? _obscureText : false, // Apply obscuring logic based on input type
        keyboardType: widget.inputType, // Use dynamic input type
        autofillHints: widget.autofillHint != null ? [widget.autofillHint!] : null, // Autofill hints
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(matcronTextFieldBorderRadius), // Rounded corners
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: matcronPrimaryColor, // Color when the field is focused
            ),
            borderRadius: BorderRadius.circular(matcronTextFieldBorderRadius),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.placeholder,
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 25.0,
          ), // Padding inside the field
          suffixIcon: _shouldObscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, // Change icon based on visibility
                    color: Colors.black,
                  ),
                  onPressed: _togglePasswordVisibility, // Toggle visibility when clicked
                )
              : null, // No icon if not a password input type
        ),
      ),
    );
  }
}
