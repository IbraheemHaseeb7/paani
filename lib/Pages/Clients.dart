import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paani/Components/Clients/ClientDetails.dart';
import 'package:paani/Components/Clients/ClientsForm.dart';
import 'package:paani/Components/Clients/ClientsInfo.dart';
import 'package:paani/Components/Title.dart';
import 'package:paani/main.dart';
import 'package:http/http.dart' as http;

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<Map<String, dynamic>> clients = [];
  int lastClientCount = 0;
  bool isFetched = false;

  // FETCHING RECORDS FROM THE SQL SERVER DATABASE USING CUSTOM MADE API ENDPOINT
  void getClients() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/query'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "select * from [Clients] c where c.[Company ID]='${MyApp.companyID}' and c.[status]='active'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> temp = [];

      for (var e in data) {
        temp.add({
          "name": e["name"],
          "phone": e["phone"],
          "address": e["address"],
          "id": e["cid"]
        });
      }

      setState(() {
        clients = temp;
      });
    }
    isFetched = true;
  }

  _ClientsState() {
    getClients();
  }

  void refreshClients() {
    setState(() {
      clients = [];
    });
    getClients();
  }

  void addClients() {
    refreshClients();
  }

  void handleSubmit() {
    showDialog(
        context: context,
        builder: (BuildContext boxContext) {
          double boxWidth = MediaQuery.of(boxContext).size.width;

          return AlertDialog(
            title: const Text(
              "Create new Client",
              style: TextStyle(color: Colors.blue),
            ),
            content: ClientsForm(addClients: addClients),
          );
        });
  }

  void handleDelete(int index) async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "update Clients set [status]='removed' where cid='${clients[index]["id"]}'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  void openDialogue(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ClientDetails(client: clients[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
          padding: EdgeInsets.only(top: 10),
          width: screenWidth,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTitle(title: "Manage Clients"),
              ((() {
                if (!isFetched) {
                  return Container(
                      width: screenWidth,
                      height: screenHeight - 200,
                      child: const Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ));
                }
                return Container(
                  width: screenWidth * 0.8,
                  height: 500,
                  child: ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            openDialogue(index);
                          },
                          child: ClientsInformation(
                              client: clients[index],
                              delete: handleDelete,
                              index: index),
                        );
                      }),
                );
              })()),
            ],
          )),
    );
  }
}
