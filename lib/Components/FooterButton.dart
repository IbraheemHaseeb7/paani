import 'package:flutter/material.dart';

class FooterButton extends StatefulWidget {
  String name;
  Icon icon;
  Function(String) makeSelection;
  FooterButton(
      {super.key,
      required this.name,
      required this.icon,
      required this.makeSelection});

  @override
  FooterButtonState createState() => FooterButtonState();
}

class FooterButtonState extends State<FooterButton> {
  void handleClick() {
    widget.makeSelection(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return (ElevatedButton(
      style: ButtonStyle(
          shadowColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
          shape: MaterialStateProperty.all(CircleBorder())),
      onPressed: handleClick,
      child: Container(
          height: 60,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon,
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 10),
                )
              ])),
    ));
  }
}
