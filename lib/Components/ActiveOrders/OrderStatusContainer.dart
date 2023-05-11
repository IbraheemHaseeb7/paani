import 'package:flutter/material.dart';

class OrderStatusContainer extends StatelessWidget {
  String returning, give, status;
  OrderStatusContainer(
      {super.key,
      required this.returning,
      required this.give,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LittleBox(value: "Return: $returning"),
          LittleBox(value: "Give: $give"),
          LittleBox(value: status),
        ],
      ),
    );
  }
}

class LittleBox extends StatelessWidget {
  String value;
  LittleBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(5),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
