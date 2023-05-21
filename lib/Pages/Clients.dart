import 'package:flutter/material.dart';
import 'package:paani/Components/Clients/ClientDetails.dart';
import 'package:paani/Components/Clients/ClientsForm.dart';
import 'package:paani/Components/Clients/ClientsInfo.dart';
import 'package:paani/Components/Title.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<Map<String, String>> clients = [
    {"name": "Luqman", "address": "Meezan Bank", "phone": "0321 1234567"},
    {"name": "Luqman", "address": "Meezan Bank", "phone": "0321 1234567"},
    {"name": "Luqman", "address": "Meezan Bank", "phone": "0321 1234567"},
    {"name": "Luqman", "address": "Meezan Bank", "phone": "0321 1234567"},
  ];

  @override
  Widget build(BuildContext context) {
    void addClients(Map<String, String> client) {
      setState(() {
        clients.add(client);
      });
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

    void handleDelete(int index) {
      setState(() {
        clients.remove(clients[index]);
      });
    }

    void openDialogue(int index) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ClientDetails(client: clients[index]);
          });
    }

    double screenWidth = MediaQuery.of(context).size.width;

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
              Container(
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
              )
            ],
          )),
    );
  }
}
