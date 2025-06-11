import 'package:flutter/material.dart';

class TextFieldLoginWidget extends StatelessWidget {
  const TextFieldLoginWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
