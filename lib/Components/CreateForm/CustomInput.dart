import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  // CONSTRUCTOR
  Function(String, String?) setSelection;
  String name;
  String label;
  double size;
  Icon icon;
  String? defaultValue;
  Function(String)? updateValue;
  CustomInput(
      {super.key,
      required this.setSelection,
      required this.name,
      required this.label,
      required this.icon,
      required this.size,
      this.updateValue,
      this.defaultValue});
  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleChange(String value) {
      setSelection(name, value);
      if (name == "amount" && updateValue != null) {
        updateValue!(value);
      }
    }

    // SIDE VARIABES
    TextEditingController tec = TextEditingController();
    if (defaultValue != null) {
      tec.text = defaultValue!;
    }

    // RENDERING COMPONENTS
    return (Container(
      margin: EdgeInsets.only(bottom: 20),
      width: size,
      child: TextField(
        // controller: tec,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: label,
            prefixIcon: icon),
        onChanged: handleChange,
      ),
    ));
  }
}
