import 'package:flutter/material.dart';

class CustomDropDown {
  static customDropDownFiled({String? defaultValue, List<String>? dropDownList, void Function(String?)? onChanged}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: defaultValue,
          items: dropDownList!.map((String items) {
            return DropdownMenuItem<String>(value: items, child: Text(items));
          }).toList(),
          onChanged: onChanged),
    );
  }
}
