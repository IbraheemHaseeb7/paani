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
      home: LoginPage(),
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
  List<User> users = [User("Ali Mussadiq", "admin", "123", "a1s2d3f4"), User("Rashid Nadeem", "rider", "234", "f4d3s2a1")];

  void handleChange(String val, String type) {
    inputs[type] = val;
  }

  @override
  Widget build(BuildContext context) {
  double? screenWidth = MediaQuery.of(context).size.width;
    return (
      Scaffold(body:
        Flex(direction: Axis.vertical, crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Container(height: 400, child: Image(image: AssetImage("/home/ibraheem/myWork/dart/paani/lib/Assets/image.jpeg"))),
          Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.only(left: 20, right: 20) ,child:
            TextField(onChanged: (val) => handleChange(val, "username"),
              decoration:
                const InputDecoration(
                  label: Text("username"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box)))),
          Container(padding: EdgeInsets.only(left: 20, right: 20), child:
            TextField(obscureText: _isPass, onChanged: (String val) => handleChange(val, "password"),
              decoration: InputDecoration(
                label: const Text("password"),
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(onPressed: (){ setState(() {
                  _isPass = !_isPass;
                }); }, icon: const Icon(Icons.view_agenda))))),
          Container(child:
            Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(padding: EdgeInsets.only(top: 10, left: 20, bottom: 10), child:
                DecoratedBox(decoration: ShapeDecoration(color: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),child:
                  RadioMenuButton(
                    child: Text('Admin', style: TextStyle(color: Colors.white)),
                    value: "admin",
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ))
                  ),
              Padding(padding: EdgeInsets.only(top: 10, right: 20, bottom: 10), child:
              DecoratedBox(decoration: ShapeDecoration(color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), child:
              RadioMenuButton(
                child: Text('Rider', style: TextStyle(color: Colors.white)),
                value: "rider",
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                }, // activeColor: Colors.blue, // Change the active color
              )))
            ],)
              ),
            Container(width: screenWidth, height: 40,padding: EdgeInsets.only(left: 20, right:20),child:
              ElevatedButton(onPressed: () {
                if (_selectedValue == "admin") {
                  bool _loggingIn = false;
                  for (var u in users) {
                    if (u.title == "admin" && u.name == inputs["username"] && u.password == inputs["password"]) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                    if (u.title == "rider" && u.name == inputs["username"] && u.password == inputs["password"]) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
              }, child: const Text("Login")),
            ),
            ],
          ),
      )
    );
  }
}
