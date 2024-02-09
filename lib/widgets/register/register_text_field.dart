import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;
  final String? Function(String?)? validator;

  const RegisterTextField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
      ),
      validator: validator,
    );
  }
}
