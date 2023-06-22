import 'dart:async';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paani/Classes/User.dart';
import 'package:paani/Pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paani/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String accountType = "admin";
  static User activeUser = User("Munchi Kaka", "admin", "123", "a1s2d3f4");
  MyApp({super.key});

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      home: HomePage(user: activeUser),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isPass = true;
  var _selectedValue;
  TextEditingController pass = TextEditingController();
  TextEditingController user = TextEditingController();
  Map<String, String> inputs = {};

  CollectionReference users = MyApp.firestore.collection("users");

  Future<User> getUser(String name, String password) async {
    Map data = {};
    Future<QuerySnapshot> res = users
        .where("name", isEqualTo: name)
        .where("password", isEqualTo: password)
        .get();
    await res.then((value) {
      value.docs.forEach((element) {
        data = element.data() as Map;
      });
    });
    if (data.isEmpty) {
      return User.empty();
    } else {
      return User(data["name"] as String, data["title"] as String,
          data["id"] as String, data["password"] as String);
    }
  }

  void handleChange(String val, String type) {
    inputs[type] = val;
  }

  void clearInputs() {
    pass.clear();
    user.clear();
    inputs["username"] = "";
    inputs["password"] = "";
  }

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;
    return (Scaffold(
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: screenWidth,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage("../lib/Assets/image.png"),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                  controller: user,
                  onChanged: (val) => handleChange(val, "username"),
                  decoration: const InputDecoration(
                      label: Text("username"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_box)))),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                  controller: pass,
                  obscureText: _isPass,
                  onChanged: (String val) => handleChange(val, "password"),
                  decoration: InputDecoration(
                      label: const Text("password"),
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPass = !_isPass;
                            });
                          },
                          icon: const Icon(Icons.view_agenda))))),
          Container(
              height: 70,
              child: CustomRadioButton(
                customShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500)),
                shapeRadius: 20,
                spacing: 10,
                elevation: 10,
                absoluteZeroSpacing: false,
                unSelectedColor: Color.fromARGB(136, 33, 149, 243),
                buttonLables: const [
                  'Admin',
                  'Rider',
                ],
                buttonValues: const [
                  "admin",
                  "rider",
                ],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (value) {
                  _selectedValue = value;
                },
                selectedColor: Colors.blue,
              )),
          Container(
            width: screenWidth,
            height: 100,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: ElevatedButton(
                onPressed: () {
                  if (_selectedValue == "admin") {
                    bool _loggingIn = false;
                    getUser(inputs["username"] ?? "", inputs["password"] ?? "")
                        .then((value) {
                      if (value.name != null) {
                        MyApp.activeUser = value;
                        MyApp.accountType = value.title ?? "";
                        clearInputs();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(user: value)));
                        _loggingIn = true;
                        return;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Input!'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        );
                      }
                    });
                  } else if (_selectedValue == "rider") {
                    bool _loggingIn = false;
                    getUser(inputs["username"] ?? "", inputs["password"] ?? "")
                        .then((value) {
                      if (value.name != null) {
                        MyApp.activeUser = value;
                        MyApp.accountType = "rider";
                        clearInputs();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(user: value)));
                        _loggingIn = true;
                        return;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Input!'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Text("Login")),
          ),
        ],
      ),
    ));
  }
}
