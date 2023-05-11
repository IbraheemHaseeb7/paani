import 'package:flutter/material.dart';
import 'package:paani/Components/Riders/RiderContainer.dart';
import 'package:paani/Components/Title.dart';

class Riders extends StatefulWidget {
  Riders({super.key});

  @override
  _RidersState createState() => _RidersState();
}

class _RidersState extends State<Riders> {
  List<Map<String, String>> riders = [
    {
      "name": "Suqlain Mushtaq",
      "phone": "03334574770",
      "salary": "30000",
      "totalDeliveries": "300",
      "id": "1"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleDelete(int index) {
      setState(() {
        riders.remove(riders[index]);
      });
    }

    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(top: 10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          CustomTitle(title: "Riders"),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight - 250,
            child: ListView.builder(
                itemCount: riders.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: RiderContainer(
                        rider: riders[index],
                        index: index,
                        delete: handleDelete),
                  );
                }),
          )
        ],
      ),
    );
  }
}
