import 'package:flutter/material.dart';
import 'package:paani/Components/Riders/AddRiderForm.dart';

class AddRider extends StatefulWidget {
  Function showTheDialogue;
  Function(Map<String, String>) addRider;
  AddRider({super.key, required this.showTheDialogue, required this.addRider});

  AddRiderState createState() => AddRiderState();
}

class AddRiderState extends State<AddRider> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(children: [
          GestureDetector(
            onVerticalDragEnd: (d) {
              widget.showTheDialogue();
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              width: screenWidth,
              height: screenHeight * 0.6,
              child: AddRiderForm(
                  addRider: widget.addRider,
                  showTheDialogue: widget.showTheDialogue),
            ),
          )
        ]));
  }
}
