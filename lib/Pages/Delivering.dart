import 'package:flutter/material.dart';
import 'package:paani/Components/Delivering/DeliveringOrders.dart';
import 'package:paani/Components/Title.dart';

class Delivering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.all(10),
        width: width,
        child: Flex(
            direction: Axis.vertical,
            children: [CustomTitle(title: "My Orders"), DeliveringOrders()]));
  }
}
