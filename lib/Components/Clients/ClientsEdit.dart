import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';

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

    void handleSubmit() {
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
