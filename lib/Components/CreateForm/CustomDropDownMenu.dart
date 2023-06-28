import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  Function(String, String?) setSelection;
  List<String> options;
  CustomDropDownMenu({
    Key? key,
    required this.setSelection,
    required this.options,
  }) : super(key: key);

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

    if (widget.options.isEmpty) {
      return CircularProgressIndicator();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: screenWidth! * 0.8,
      child: DropdownMenu<String>(
        leadingIcon: Icon(Icons.location_city),
        hintText: "Address",
        width: screenWidth * 0.8,
        enableSearch: true,
        controller: tec,
        onSelected: handleSelection,
        dropdownMenuEntries: widget.options.map((e) {
          return DropdownMenuEntry(value: e, label: e);
        }).toList(),
      ),
    );
  }
}
