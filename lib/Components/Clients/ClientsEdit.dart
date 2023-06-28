import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/main.dart';
import 'package:http/http.dart' as http;

class ClientEdit extends StatefulWidget {
  Map<String, dynamic?> client;
  Map<String, String?> input;
  ClientEdit({super.key, required this.client, required this.input});

  @override
  _ClientEditState createState() => _ClientEditState();
}

class _ClientEditState extends State<ClientEdit> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // setting initial values for the input control
    widget.input["name"] = widget.client["name"];
    widget.input["phone"] = widget.client["phone"];
    widget.input["address"] = widget.client["address"];

    void setSelection(String name, String? value) {
      widget.input[name] = value;
    }

    void handleSubmit() async {
      const url =
          'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

      final headers = {'Content-Type': 'application/json'};
      final body = {
        'query':
            "update Clients set [name]='${widget.input["name"]}', [address]='${widget.input["address"]}', [phone]='${widget.input["phone"]}' where cid='${widget.client["id"]}'"
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
          "Edit Client Details",
          style: TextStyle(color: Colors.blue),
        ),
        content: Container(
            height: 320,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomInput(
                      defaultValue: widget.client["name"],
                      setSelection: setSelection,
                      name: "name",
                      label: "Name",
                      icon: const Icon(Icons.man_2),
                      size: screenWidth * 0.9),
                  CustomInput(
                      defaultValue: widget.client["address"],
                      setSelection: setSelection,
                      name: "address",
                      label: "Address",
                      icon: const Icon(Icons.home),
                      size: screenWidth * 0.9),
                  CustomInput(
                      defaultValue: widget.client["phone"],
                      setSelection: setSelection,
                      name: "phone",
                      label: "Phone",
                      icon: const Icon(Icons.phone),
                      size: screenWidth * 0.9),
                  Container(
                      width: screenWidth,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: handleSubmit, child: const Text("Submit")))
                ])));
  }
}
