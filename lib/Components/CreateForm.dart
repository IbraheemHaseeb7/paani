import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomDatePicker.dart';
import 'package:paani/Components/CreateForm/CustomDropDownMenu.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/Components/CreateForm/CustomInputContainer.dart';
import 'package:paani/Components/CreateForm/CustomPlaceOrderContainer.dart';

class CreateForm extends StatefulWidget {
  CreateForm({super.key});

  @override
  CreateFormState createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  // BASIC VARIABLES
  Map<String, String?> inputs = {};

  // FUNCTIONS
  void setSelection(String key, String? value) {
    inputs[key] = value;
  }

  String amount = "0";
  String previous = "0";
  void updateValue(String value) {
    setState(() {
      if (value == "")
        amount = "0";
      else
        amount = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;

    //RENDERING COMPONENTS
    return (Container(
        margin: EdgeInsets.only(top: 20),
        width: screenWidth,
        child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomDropDownMenu(
                setSelection: setSelection,
              ),
              CustomInput(
                  size: screenWidth * 0.8,
                  setSelection: setSelection,
                  name: "name",
                  label: "Name",
                  icon: const Icon(Icons.man)),
              CustomInput(
                size: screenWidth * 0.8,
                setSelection: setSelection,
                name: "amount",
                label: "Amount",
                icon: const Icon(Icons.money),
                updateValue: updateValue,
              ),
              CustomDatePicker(),
              CustomInputContainer(setSelection: setSelection),
              CustomPlaceOrderContainer(current: amount, previous: previous),
              Container(
                  height: 50,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                      onPressed: () {
                        print(inputs);
                      },
                      child: const Text("Place Order",
                          style: TextStyle(fontSize: 20)))),
            ])));
  }
}
