import 'package:flutter/material.dart';

class DailyFormConfig {
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  DailyFormConfig({
    required this.hintText,
    this.icon,
    this.obscureText = false,
    required this.controller,
    required this.validator,
  });
}
