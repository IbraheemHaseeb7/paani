import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/main.dart';

class ClientsForm extends StatefulWidget {
  Function() addClients;
  String Function() getCustomerId;
  ClientsForm(
      {super.key, required this.addClients, required this.getCustomerId});

  @override
  _ClientsFormState createState() => _ClientsFormState();
}

class _ClientsFormState extends State<ClientsForm> {
  Map<String, String> input = {};
  @override
  Widget build(BuildContext context) {
    void setSelection(String name, String? value) {
      input[name] = value ?? "";
    }

    double screenWidth = MediaQuery.of(context).size.width;

    void handleSubmit() {
      if ((input["name"] == "" || input["name"] == null) ||
          (input["address"] == "" || input["address"] == null) ||
          (input["phone"] == "" || input["phone"] == null)) {
      } else {
        MyApp.firestore.collection("clients").doc(widget.getCustomerId()).set({
          "name": input["name"],
          "phone": input["phone"],
          "address": input["address"],
          "id": widget.getCustomerId()
        });
        widget.addClients();
        Navigator.of(context).pop();
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: screenWidth,
      height: 300,
      child: ListView(children: [
        Flex(
          direction: Axis.vertical,
          children: [
            CustomInput(
                setSelection: setSelection,
                name: "name",
                label: "Name",
                icon: const Icon(Icons.man),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "address",
                label: "Address",
                icon: const Icon(Icons.house),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "phone",
                label: "Phone",
                icon: const Icon(Icons.phone),
                size: screenWidth * 0.8),
            Container(
              width: screenWidth * 0.8,
              height: 50,
              child: ElevatedButton(
                  onPressed: handleSubmit, child: const Text("Submit")),
            )
          ],
        )
      ]),
    );
  }
}
