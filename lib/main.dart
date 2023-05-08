import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:paani/Classes/User.dart';
import 'package:paani/Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      home: HomePage(user: User("Ali Mussadiq", "admin", "123", "a1s2d3f4")),
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
  Map<String, String> inputs = {};
  List<User> users = [
    User("Ali Mussadiq", "admin", "123", "a1s2d3f4"),
    User("Rashid Nadeem", "rider", "234", "f4d3s2a1")
  ];

  void handleChange(String val, String type) {
    inputs[type] = val;
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
                image: AssetImage("../Assets/image.png"),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                  onChanged: (val) => handleChange(val, "username"),
                  decoration: const InputDecoration(
                      label: Text("username"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_box)))),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
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
                    for (var u in users) {
                      if (u.title == "admin" &&
                          u.name == inputs["username"] &&
                          u.password == inputs["password"]) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(user: u)));
                        _loggingIn = true;
                        break;
                      }
                    }
                    if (!_loggingIn) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Input!'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(left: 10, right: 10),
                        ),
                      );
                    }
                  } else if (_selectedValue == "rider") {
                    bool _loggingIn = false;
                    for (var u in users) {
                      if (u.title == "rider" &&
                          u.name == inputs["username"] &&
                          u.password == inputs["password"]) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(user: u)));
                        _loggingIn = true;
                        break;
                      }
                    }

                    if (!_loggingIn) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Input!'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(left: 10, right: 10),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Login")),
          ),
        ],
      ),
    ));
  }
}
