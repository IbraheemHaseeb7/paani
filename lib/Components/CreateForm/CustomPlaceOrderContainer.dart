import 'package:flutter/material.dart';

class CustomPlaceOrderContainer extends StatelessWidget {
  String current, previous;
  CustomPlaceOrderContainer(
      {super.key, required this.current, required this.previous});
  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;

    return (Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(122, 33, 149, 243)),
      width: screenWidth * 0.8,
      margin: const EdgeInsets.only(bottom: 20),
      height: 150,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        direction: Axis.vertical,
        children: [
          Container(
              width: screenWidth * 0.7,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Previous",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(previous,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ])),
          Container(
              width: screenWidth * 0.7,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Current",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(this.current,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ])),
          Container(
              width: screenWidth * 0.7,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text((int.tryParse(current)! + 2000).toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ]))
        ],
      ),
    ));
  }
}
