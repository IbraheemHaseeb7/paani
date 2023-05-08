import 'package:flutter/material.dart';
import 'package:paani/Components/Title.dart';

class ActiveOrders extends StatefulWidget {
  // CONSTRUCTOR
  ActiveOrders({super.key});

  // CREATING STATE
  @override
  ActiveOrdersState createState() => ActiveOrdersState();
}

class ActiveOrdersState extends State<ActiveOrders> {
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
            CustomTitle(title: "Active Orders"),
          ],
        )));
  }
}
