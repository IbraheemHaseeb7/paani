import 'package:flutter/material.dart';
import 'package:paani/Components/Clients/ClientDetails.dart';
import 'package:paani/Components/Clients/ClientsForm.dart';
import 'package:paani/Components/Clients/ClientsInfo.dart';
import 'package:paani/Components/Title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paani/main.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<Map<String, dynamic>> clients = [];
  int lastClientCount = 0;

  // FETCHING RECORDS FROM THE FIRESTORE DATABASE
  CollectionReference client = MyApp.firestore.collection("clients");
  Future<void> getClients() async {
    Map data = {};
    Future<QuerySnapshot> res = client.get();
    await res.then((value) {
      value.docs.forEach((element) {
        data = element.data() as Map;
      });
    });
    if (data.isEmpty) {
      print("oops!");
    } else {
      List<Map<String, dynamic>> temps = [];

      res.then((value) {
        int count = 0;
        for (var e in value.docs) {
          Map<String, dynamic> temp = Map();
          Map<String, dynamic> t = e.data() as Map<String, dynamic>;
          temp["name"] = t["name"];
          temp["address"] = t["address"];
          temp["phone"] = t["phone"];
          temp["id"] = t["id"];
          temps.add(temp);
          count++;
        }

        lastClientCount = count + 1;

        setState(() {
          clients = temps;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void refreshClients() {
      setState(() {
        clients = [];
      });
      getClients();
    }

    void addClients() {
      refreshClients();
    }

    String getCustomerId() {
      return "C${lastClientCount}";
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
              content: ClientsForm(
                  addClients: addClients, getCustomerId: getCustomerId),
            );
          });
    }

    void handleDelete(int index) {
      MyApp.firestore.collection("clients").doc(clients[index]["id"]).delete();
      refreshClients();
    }

    void openDialogue(int index) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ClientDetails(client: clients[index]);
          });
    }

    getClients();

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
