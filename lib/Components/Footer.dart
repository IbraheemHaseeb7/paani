import 'package:flutter/material.dart';
import 'package:paani/Components/FooterButton.dart';

class Footer extends StatefulWidget {
  Function(String) makeSelection;
  Footer({super.key, required this.makeSelection});

  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;

    return (Container(
        decoration: BoxDecoration(color: Colors.blue),
        width: screenWidth,
        height: 70,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FooterButton(
              name: "Create",
              icon: const Icon(Icons.create),
              makeSelection: widget.makeSelection,
            ),
            FooterButton(
                name: "Active",
                icon: const Icon(Icons.local_activity_rounded),
                makeSelection: widget.makeSelection),
            FooterButton(
                name: "Riders",
                icon: const Icon(Icons.bike_scooter),
                makeSelection: widget.makeSelection),
            FooterButton(
                name: "Clients",
                icon: const Icon(Icons.cases),
                makeSelection: widget.makeSelection),
          ],
        )));
  }
}
