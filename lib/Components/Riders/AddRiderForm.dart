import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';

class AddRiderForm extends StatelessWidget {
  Function(Map<String, String>) addRider;
  Function showTheDialogue;
  AddRiderForm(
      {super.key, required this.addRider, required this.showTheDialogue});

  Map<String, String> input = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void setSelection(String name, String? value) {
      input[name] = value ?? "";
    }

    void handleSubmit() {
      addRider(input);
      showTheDialogue();
    }

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text("Add a new Rider",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            CustomInput(
                setSelection: setSelection,
                name: "name",
                label: "Name",
                icon: const Icon(Icons.man),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "phone",
                label: "Phone",
                icon: const Icon(Icons.phone),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "salary",
                label: "Salary",
                icon: const Icon(Icons.money),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "totalDeliveries",
                label: "Total Deliveries",
                icon: const Icon(Icons.pedal_bike),
                size: screenWidth * 0.8),
            CustomInput(
                setSelection: setSelection,
                name: "password",
                label: "Password",
                icon: const Icon(Icons.password),
                size: screenWidth * 0.8),
            Container(
              width: screenWidth * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text("Submit"),
              ),
            )
          ]),
    );
  }
}
