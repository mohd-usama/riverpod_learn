import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomAutoComplete {
  static customAutoCompleteField(
      {List<String>? listData,
      TextEditingController? controller,
      FocusNode? focusNode,
      void Function(String)? onSelected,
      void Function(String)? onChanged,SuggestionsController<String>? suggestionsController}) {
    return TypeAheadField<String>(
      suggestionsController: suggestionsController,
      focusNode: focusNode,
      controller: controller,
      suggestionsCallback: (pattern) {
        return listData!.where((String? option) {
          return option!.toString().toLowerCase().contains(pattern.toLowerCase());
        }).toList();
      },
      builder: (context, controller, focusNode) {
        return TextField(
            onChanged: onChanged,
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
            ));
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          tileColor: Colors.white10.withOpacity(0.01),
          title: Text(suggestion),
        );
      },
      onSelected: (String suggestion) {
        controller!.text = suggestion;
      },
    );
  }
}
