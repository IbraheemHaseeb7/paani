import 'package:flutter/material.dart';
import 'package:paani/Classes/User.dart';
import 'package:paani/Components/Footer.dart';
import 'package:paani/Components/Title.dart';
import 'package:paani/Pages/ActiveOrders.dart';
import 'package:paani/Pages/Clients.dart';
import 'package:paani/Pages/CreateNewOrder.dart';
import 'package:paani/Pages/Riders.dart';

class HomePage extends StatefulWidget {
  // CONSTRUCTOR
  User user;
  HomePage({super.key, required this.user});

  //CREATING STATE
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // BASIC VARIABLES
  String selection = "";
  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    String USER = widget.user.name;

    // FUNCTIONS
    void makeSelection(String sel) {
      setState(() {
        selection = sel;
      });
    }

    // RENDERING WIDGETS
    return (Scaffold(
      appBar: AppBar(title: Text("Welcome Back, $USER")),
      body: ((() {
        switch (selection) {
          case "Create":
            return Create();
          case "Active":
            return ActiveOrders();
          case "Riders":
            return Riders();
          case "Clients":
            return Clients();
          default:
            return Clients();
        }
      }())),
      bottomNavigationBar: Footer(makeSelection: makeSelection),
    ));
  }
}
