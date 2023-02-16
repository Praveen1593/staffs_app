import 'package:flutter/material.dart';

class AppDropdownInput extends StatelessWidget {
  final String hintText;
  final List<dynamic> options;
  final String? value;
  final String Function()? getLabel;
  final void Function(dynamic)? onChanged;

   AppDropdownInput({
    this.hintText = 'Please select an Option',
    required this.options,
    this.getLabel,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 0.0),
            errorStyle:const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: hintText,
            labelText: hintText,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((value) {
                return DropdownMenuItem(
                  value: value.name,
                  child: Text(value.name??""),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}