import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropDownMenu extends StatefulWidget {
  Function(String, String?) setSelection;
  CustomDropDownMenu({super.key, required this.setSelection});

  @override
  CustomDropDownMenuState createState() => CustomDropDownMenuState();
}

class CustomDropDownMenuState extends State<CustomDropDownMenu> {
  TextEditingController tec = TextEditingController();

  void handleSelection(String? value) {
    widget.setSelection("location", tec.text);
  }

  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    return (Container(
        margin: EdgeInsets.only(bottom: 20),
        width: screenWidth * 0.8,
        child: DropdownMenu<String>(
          leadingIcon: Icon(Icons.location_city),
          hintText: "Address",
          width: screenWidth * 0.8,
          enableSearch: true,
          controller: tec,
          onSelected: handleSelection,
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: "value", label: "Johar Town"),
            DropdownMenuEntry(value: "value", label: "Wapda Town"),
            DropdownMenuEntry(value: "value", label: "IEP Town"),
            DropdownMenuEntry(value: "value", label: "Bahria Town"),
            DropdownMenuEntry(value: "value", label: "Valencia")
          ],
        )));
  }
}
