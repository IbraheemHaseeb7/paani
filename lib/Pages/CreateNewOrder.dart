import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm.dart';
import 'package:paani/Components/Title.dart';

class Create extends StatefulWidget {
  // CONSTRUCTOR
  Create({super.key});

  // CREATING STATE
  @override
  CreateState createState() => CreateState();
}

class CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;

    // RENDERING WIDGETS
    return (Container(
        padding: EdgeInsets.only(top: 10),
        width: screenWidth,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            CustomTitle(title: "Add new Delivery Order"),
            CreateForm()
          ],
        )));
  }
}
