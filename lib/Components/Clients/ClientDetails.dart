import 'package:flutter/material.dart';

class ClientDetails extends StatelessWidget {
  Map<String, dynamic> client;
  ClientDetails({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        client["name"] ?? "",
        style: const TextStyle(color: Colors.blue),
      ),
      content: Container(
        height: 150,
        child: Flex(direction: Axis.vertical, children: [
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Address:        ",
                  style: TextStyle(color: Colors.black),
                ),
                Flexible(
                    child: Text(
                  client["address"] ?? "",
                  style: const TextStyle(color: Colors.black),
                ))
              ]),
          Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Phone No.:",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  client["phone"] ?? "",
                  style: const TextStyle(color: Colors.black),
                )
              ]),
        ]),
      ),
    );
  }
}
