import 'package:flutter/material.dart';

class RiderContainer extends StatelessWidget {
  Map<String, String> rider;
  Function(int) delete;
  int index;
  RiderContainer(
      {super.key,
      required this.rider,
      required this.delete,
      required this.index});

  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleDelete() {
      delete(index);
    }

    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.8,
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Color.fromARGB(139, 33, 149, 243),
          borderRadius: BorderRadius.circular(5)),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(rider["name"] ?? "",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          Row(children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white)),
            IconButton(
                onPressed: handleDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ])
        ],
      ),
    );
  }
}
