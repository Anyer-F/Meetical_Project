import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
