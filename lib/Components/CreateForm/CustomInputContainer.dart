import 'package:flutter/material.dart';
import 'package:paani/Components/CreateForm/CustomInput.dart';

class CustomInputContainer extends StatefulWidget {
  // CONSTRUCTOR
  Function(String, String?) setSelection;
  CustomInputContainer({super.key, required this.setSelection});

  // CREATING STATE
  @override
  CustomInputContainerState createState() => CustomInputContainerState();
}

class CustomInputContainerState extends State<CustomInputContainer> {
  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;

    // RENDERING WIDGETS
    return (Container(
      width: screenWidth * 0.8,
      child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInput(
                setSelection: widget.setSelection,
                name: "receive",
                label: "Receive",
                icon: const Icon(Icons.water_drop_sharp),
                size: screenWidth * 0.35),
            CustomInput(
                setSelection: widget.setSelection,
                name: "send",
                label: "Send",
                icon: const Icon(Icons.water_drop),
                size: screenWidth * 0.35),
          ]),
    ));
  }
}
