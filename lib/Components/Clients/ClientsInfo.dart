import 'package:flutter/material.dart';
import 'package:paani/Components/Clients/ClientsEdit.dart';

class ClientsInformation extends StatefulWidget {
  Map<String, dynamic> client;
  Function(int) delete;
  int index;
  ClientsInformation(
      {super.key,
      required this.client,
      required this.delete,
      required this.index});

  @override
  ClientsInformationState createState() => ClientsInformationState();
}

class ClientsInformationState extends State<ClientsInformation> {
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
            return ClientEdit(client: widget.client, input: input);
          });
      setState(() {
        widget.client["name"] = input["name"] ?? "";
        widget.client["address"] = input["address"] ?? "";
        widget.client["phone"] = input["phone"] ?? "";
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
            child: Text(widget.client["name"] ?? "",
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
