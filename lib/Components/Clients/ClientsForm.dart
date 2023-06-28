import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';
import 'package:paani/main.dart';
import 'package:http/http.dart' as http;

class ClientsForm extends StatefulWidget {
  Function() addClients;
  ClientsForm({super.key, required this.addClients});

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

    void handleSubmit() async {
      if ((input["name"] == "" || input["name"] == null) ||
          (input["address"] == "" || input["address"] == null) ||
          (input["phone"] == "" || input["phone"] == null)) {
      } else {
        const url =
            'https://paani-api.netlify.app/.netlify/functions/api/insert'; // Replace with your API endpoint URL

        final headers = {'Content-Type': 'application/json'};
        final body = {
          'query':
              "begin tran declare @temp varchar(5) set @temp = dbo.clientID(); insert into Clients ([name], [address], [phone], [status], [Company ID], cid) values ('${input["name"]}', '${input["address"]}', '${input["phone"]}', 'active', '${MyApp.companyID}', @temp) commit"
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
