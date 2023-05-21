import 'package:flutter/material.dart';
import 'package:paani/Components/FooterButton.dart';
import 'package:paani/main.dart';

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

    Widget render(Widget first, Widget second) {
      if (MyApp.accountType == "admin") {
        return first;
      } else {
        return second;
      }
    }

    return (Container(
        decoration: BoxDecoration(color: Colors.blue),
        width: screenWidth,
        height: 70,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            render(
                FooterButton(
                  name: "Create",
                  icon: const Icon(Icons.create),
                  makeSelection: widget.makeSelection,
                ),
                Container()),
            render(
                FooterButton(
                    name: "Active",
                    icon: const Icon(Icons.local_activity_rounded),
                    makeSelection: widget.makeSelection),
                Container()),
            render(
                Container(),
                FooterButton(
                    name: "Active",
                    icon: const Icon(Icons.local_activity_rounded),
                    makeSelection: widget.makeSelection)),
            render(
                FooterButton(
                    name: "Riders",
                    icon: const Icon(Icons.bike_scooter),
                    makeSelection: widget.makeSelection),
                Container()),
            render(
                FooterButton(
                    name: "Clients",
                    icon: const Icon(Icons.cases),
                    makeSelection: widget.makeSelection),
                Container()),
          ],
        )));
  }
}
