import 'package:flutter/material.dart';

class RiderDetails extends StatelessWidget {
  Map<String, dynamic> rider;
  RiderDetails({super.key, required this.rider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        rider["name"] ?? "",
        style: const TextStyle(color: Colors.blue),
      ),
      content: Container(
        height: 70,
        child: Flex(direction: Axis.vertical, children: [
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Phone No.:",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  rider["phone"] ?? "",
                  style: const TextStyle(color: Colors.black),
                )
              ]),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Salary: ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  rider["salary"] ?? "",
                  style: const TextStyle(color: Colors.black),
                )
              ]),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Deliveries: ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  rider["totalDeliveries"] ?? "",
                  style: const TextStyle(color: Colors.black),
                )
              ]),
        ]),
      ),
    );
  }
}
