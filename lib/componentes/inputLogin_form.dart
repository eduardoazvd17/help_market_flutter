import 'package:flutter/material.dart';

class InputLoginForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget icon;
  final bool obscureText;
  final TextInputType keyboardType;

  InputLoginForm({
    @required this.controller,
    this.icon,
    this.hintText = "Default",
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
