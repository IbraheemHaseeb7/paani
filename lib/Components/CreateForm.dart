import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paani/Components/CreateForm/CustomDatePicker.dart';
import 'package:paani/Components/CreateForm/CustomDropDownMenu.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/Components/CreateForm/CustomInputContainer.dart';
import 'package:paani/Components/CreateForm/CustomPlaceOrderContainer.dart';
import 'package:http/http.dart' as http;
import 'package:paani/main.dart';

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
  List<String> addresses = [];
  void updateValue(String value) {
    setState(() {
      if (value == "") {
        amount = "0";
      } else {
        amount = value;
      }
    });
  }

  void getAddresses() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/query'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "select [address] from Clients c where c.[status]='active' and c.[Company ID]='${MyApp.companyID}'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<String> temp = [];

      for (var e in data) {
        temp.add(e["address"]);
      }

      setState(() {
        addresses = temp;
      });
    }
  }

  void handleSubmit() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/insert'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "exec addOrder @address='${inputs["location"]}', @amountPaid=${inputs["amount"]} , @send=${inputs["send"]} , @receive=${inputs["receive"]}, @companyID='${MyApp.companyID}', @duetime='${inputs["date"]}'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    Fluttertoast.showToast(
        msg: "Successfully created a new Order",
        timeInSecForIosWeb: 3,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        webBgColor: "#2196F3",
        backgroundColor: Color(0xFF2196F3));

    setState(() {
      inputs = {};
    });
  }

  CreateFormState() {
    getAddresses();
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
                options: addresses,
                setSelection: setSelection,
              ),
              // CustomInput(
              //     size: screenWidth * 0.8,
              //     setSelection: setSelection,
              //     name: "name",
              //     label: "Name",
              //     icon: const Icon(Icons.man)),
              CustomInput(
                size: screenWidth * 0.8,
                setSelection: setSelection,
                name: "amount",
                label: "Amount",
                icon: const Icon(Icons.money),
                updateValue: updateValue,
              ),
              CustomDatePicker(setSelection: setSelection),
              CustomInputContainer(setSelection: setSelection),
              CustomPlaceOrderContainer(current: amount, previous: previous),
              Container(
                  height: 50,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                      onPressed: handleSubmit,
                      child: const Text("Place Order",
                          style: TextStyle(fontSize: 20)))),
            ])));
  }
}
