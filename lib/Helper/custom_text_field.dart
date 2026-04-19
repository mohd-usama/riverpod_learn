import 'package:flutter/material.dart';

class CustomTextFiled {
  static textFiledCustom(
      {TextEditingController? controller,
      void Function(String)? onChanged,
      bool obscureText = false,
      Widget? suffixIcon,
      String? labelText}) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: labelText, suffixIcon: suffixIcon),
    );
  }
}
