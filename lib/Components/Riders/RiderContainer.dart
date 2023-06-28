import 'package:flutter/material.dart';
import 'package:paani/Components/Riders/RiderEdit.dart';

class RiderContainer extends StatefulWidget {
  Map<String, dynamic> rider;
  Function(int) delete;
  int index;
  RiderContainer(
      {super.key,
      required this.rider,
      required this.delete,
      required this.index});

  @override
  RiderContainerState createState() => RiderContainerState();
}

class RiderContainerState extends State<RiderContainer> {
  Map<String, String?> input = {};

  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleDelete() {
      widget.delete(widget.index);
    }

    void handleEdit() async {
      await showDialog(
          context: context,
          builder: (BuildContext editContext) {
            return RiderEdit(
              rider: widget.rider,
              input: input,
            );
          });
      setState(() {
        widget.rider["name"] = input["name"] ?? "";
        widget.rider["phone"] = input["phone"] ?? "";
        widget.rider["salary"] = input["salary"] ?? "";
        widget.rider["totalDeliveries"] = input["totalDeliveries"] ?? "";
      });
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
            child: Text(widget.rider["name"] ?? "",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          Row(children: [
            IconButton(
                onPressed: handleEdit,
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
