import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/main.dart';
import 'package:http/http.dart' as http;

class RiderEdit extends StatefulWidget {
  Map<String, dynamic> rider;
  Map<String, String?> input;
  RiderEdit({super.key, required this.rider, required this.input});

  @override
  _RiderEditState createState() => _RiderEditState();
}

class _RiderEditState extends State<RiderEdit> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // setting initial values for the input control
    widget.input["name"] = widget.rider["name"];
    widget.input["phone"] = widget.rider["phone"];
    widget.input["salary"] = widget.rider["salary"];

    void setSelection(String name, String? value) {
      widget.input[name] = value;
    }

    void handleSubmit() async {
      const url =
          'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

      final headers = {'Content-Type': 'application/json'};
      final body = {
        'query':
            "update Riders set [name]='${widget.input["name"]}', [phone]='${widget.input["phone"]}', [salary]=${widget.input["salary"]} where rid='${widget.rider["id"]}'"
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      Navigator.of(context).pop();
    }

    return AlertDialog(
        title: const Text(
          "Edit Rider Details",
          style: TextStyle(color: Colors.blue),
        ),
        content: Container(
            height: 370,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomInput(
                      defaultValue: widget.rider["name"],
                      setSelection: setSelection,
                      name: "name",
                      label: "Name",
                      icon: const Icon(Icons.man_2),
                      size: screenWidth * 0.9),
                  CustomInput(
                      defaultValue: widget.rider["phone"],
                      setSelection: setSelection,
                      name: "phone",
                      label: "Phone",
                      icon: const Icon(Icons.phone),
                      size: screenWidth * 0.9),
                  CustomInput(
                      defaultValue: widget.rider["salary"],
                      setSelection: setSelection,
                      name: "salary",
                      label: "Salary",
                      icon: const Icon(Icons.money),
                      size: screenWidth * 0.9),
                  Container(
                      width: screenWidth,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: handleSubmit, child: const Text("Submit")))
                ])));
  }
}
