import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paani/Components/Riders/AddRider.dart';
import 'package:paani/Components/Riders/RiderContainer.dart';
import 'package:paani/Components/Riders/RiderDetails.dart';
import 'package:paani/Components/Title.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Riders extends StatefulWidget {
  Riders({super.key});

  @override
  _RidersState createState() => _RidersState();
}

class _RidersState extends State<Riders> {
  List<Map<String, dynamic>> riders = [];
  int lastRiderCount = 0;

  // FETCHING RECORDS FROM THE FIRESTORE DATABASE
  void getRiders() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/query'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "select [name], rid, salary, phone, (select count(rid) as totalDeliveries from [Orders Details] od where od.rid=r.rid) as totalDeliveries from Riders r where r.[Company ID]='${MyApp.companyID}' and r.[status]='working'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, String>> temp = [];

      for (var e in data) {
        temp.add({
          "name": e["name"],
          "phone": e["phone"],
          "salary": e["salary"].toString(),
          "id": e["rid"],
          "totalDeliveries": e["totalDeliveries"].toString()
        });
      }

      setState(() {
        riders = temp;
      });
    }

    isFetched = true;
  }

  _RidersState() {
    getRiders();
  }

  bool _isVisible = false;
  bool isFetched = false;

  // FUNCTIONS
  void refereshRiders() {
    setState(() {
      riders = [];
      getRiders();
    });
  }

  void handleDelete(int index) async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "begin tran update Riders set [status]='fired' where rid='${riders[index]["id"]}' update Users set [status]='fired' where [uid]='${riders[index]["id"]}' commit"
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
        builder: (BuildContext detailsContext) {
          return RiderDetails(rider: riders[index]);
        });
  }

  void showTheDialogue() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    void addRider(Map<String, String> rider) async {
      if ((rider["name"] == "" || rider["name"] == null) ||
          (rider["salary"] == "" || rider["salary"] == null) ||
          (rider["phone"] == "" || rider["phone"] == null) ||
          (rider["password"] == "" || rider["password"] == null)) {
      } else {
        const url =
            'https://paani-api.netlify.app/.netlify/functions/api/insert'; // Replace with your API endpoint URL

        final headers = {'Content-Type': 'application/json'};
        final body = {
          'query':
              "exec addRider @name='${rider["name"]}', @phone='${rider["phone"]}', @salary=${rider["salary"]}, @password='${rider["password"]}', @companyID='${MyApp.companyID}'"
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

        refereshRiders();
      }
    }

    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTheDialogue();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            Container(
                width: screenWidth,
                margin: const EdgeInsets.only(top: 10),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    CustomTitle(title: "Riders"),
                    (() {
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
                      } else {
                        return Container(
                          width: screenWidth * 0.8,
                          height: screenHeight - 250,
                          child: ListView.builder(
                              itemCount: riders.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    openDialogue(index);
                                  },
                                  child: RiderContainer(
                                      rider: riders[index],
                                      index: index,
                                      delete: handleDelete),
                                );
                              }),
                        );
                      }
                    })(),
                  ],
                )),
            (() {
              if (_isVisible) {
                return GestureDetector(
                    onTap: () {
                      showTheDialogue();
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isVisible ? 1.0 : 0.0,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(73, 0, 0, 0)),
                      ),
                    ));
              } else {
                return Container();
              }
            })(),
            AnimatedPositioned(
              bottom: _isVisible ? -(screenHeight * 0.4) : -screenHeight,
              duration: const Duration(milliseconds: 500),
              child: AddRider(
                  showTheDialogue: showTheDialogue, addRider: addRider),
              curve: Curves.easeOutBack,
            ),
          ],
        ));
  }
}
