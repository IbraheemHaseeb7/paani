import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  // CONSTRUCTOR
  Function(String, String?) setSelection;
  String name;
  String label;
  double size;
  Icon icon;
  Function(String)? updateValue;
  CustomInput(
      {super.key,
      required this.setSelection,
      required this.name,
      required this.label,
      required this.icon,
      required this.size,
      this.updateValue});
  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleChange(String value) {
      setSelection(name, value);
      if (name == "amount" && updateValue != null) {
        updateValue!(value);
      }
    }

    // RENDERING COMPONENTS
    return (Container(
      margin: EdgeInsets.only(bottom: 20),
      width: size,
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: label,
            prefixIcon: icon),
        onChanged: handleChange,
      ),
    ));
  }
}
