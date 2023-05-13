import 'package:flutter/material.dart';
import 'package:paani/Components/Riders/AddRider.dart';
import 'package:paani/Components/Riders/RiderContainer.dart';
import 'package:paani/Components/Riders/RiderDetails.dart';
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
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // FUNCTIONS
    void handleDelete(int index) {
      setState(() {
        riders.remove(riders[index]);
      });
    }

    void openDialogue(int index) {
      showDialog(
          context: context,
          builder: (BuildContext detailsContext) {
            return RiderDetails(rider: riders[index]);
          });
    }

    void showTheDialogue() {
      setState(() {
        _isVisible = !_isVisible;
      });
    }

    void addRider(Map<String, String> rider) {
      setState(() {
        riders.add(rider);
      });
    }

    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTheDialogue();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: [
            Container(
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
                              onTap: () {
                                openDialogue(index);
                              },
                              child: RiderContainer(
                                  rider: riders[index],
                                  index: index,
                                  delete: handleDelete),
                            );
                          }),
                    ),
                  ],
                )),
            (() {
              if (_isVisible) {
                return GestureDetector(
                    onTap: () {
                      showTheDialogue();
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isVisible ? 1.0 : 0.0,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(73, 0, 0, 0)),
                      ),
                    ));
              } else {
                return Container();
              }
            })(),
            AnimatedPositioned(
              bottom: _isVisible ? -(screenHeight * 0.4) : -screenHeight,
              duration: const Duration(milliseconds: 500),
              child: AddRider(
                  showTheDialogue: showTheDialogue, addRider: addRider),
              curve: Curves.easeOutBack,
            ),
          ],
        ));
  }
}
