import 'package:flutter/material.dart';
import 'package:paani/Components/ActiveOrders/Order.dart';
import 'package:paani/main.dart';

class ActiveOrdersContainer extends StatefulWidget {
  @override
  ActiveOrdersContainerState createState() => ActiveOrdersContainerState();
}

class ActiveOrdersContainerState extends State<ActiveOrdersContainer> {
  List<Map<String, String>> orders = [
    {
      "address": "205 B-3 Valencia Town",
      "give": "2",
      "returning": "0",
      "status": "active",
      "amount": "2000",
      "name": "Rashid Nadeem",
      "id": "1",
      "date": "22-05-2023"
    },
    {
      "address": "174 C-3 Engineers Town",
      "give": "2",
      "returning": "0",
      "status": "active",
      "amount": "1000",
      "name": "Haseeb Bashir",
      "id": "2",
      "date": "22-05-2023"
    },
    {
      "address": "23-B Al-Makkah Colony",
      "give": "1",
      "returning": "1",
      "status": "delivering",
      "amount": "2000",
      "name": "Ali Khalid",
      "id": "3",
      "date": "22-05-2023"
    },
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void deleteOrder(int index) {
      setState(() {
        orders.remove(orders[index]);
      });
    }

    void handleSelect(int index) {
      showDialog(
          context: context,
          builder: (BuildContext boxContext) {
            double boxWidth = MediaQuery.of(boxContext).size.width;

            return AlertDialog(
              title: Text(orders[index]["address"] ?? ""),
              content: Container(
                  height: null,
                  width: boxWidth,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Name"),
                              Text(orders[index]["name"] ?? "")
                            ]),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Return"),
                              Text(orders[index]["returning"] ?? "")
                            ]),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Give"),
                              Text(orders[index]["give"] ?? "")
                            ]),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Status"),
                              Text(orders[index]["status"] ?? "")
                            ]),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Amount"),
                              Text(orders[index]["amount"] ?? "")
                            ]),
                        Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Rider"),
                              Text(orders[index]["rider"] ?? "")
                            ]),
                      ])),
              actions: [
                Container(
                  width: boxWidth,
                  child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(boxContext).pop();
                            },
                            icon: const Icon(Icons.close)),

                        // ACCEPT BUTTON DISPLAYED FOR RIDERS ONLY
                        (() {
                          if (MyApp.accountType == "rider" &&
                              orders[index]["status"] == "active") {
                            return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    orders[index]["status"] = "delivering";
                                    orders[index]["rider"] =
                                        MyApp.activeUser.name;
                                  });
                                  Navigator.of(boxContext).pop();
                                },
                                child: const Text("Accept"));
                          }
                          return Container();
                        })(),
                        // COMPLETED BUTTON FOR RIDER WHEN THE ORDER IS COMPLETED
                        (() {
                          if (MyApp.accountType == "rider" &&
                              orders[index]["status"] == "delivering") {
                            return ElevatedButton(
                                onPressed: () {
                                  Navigator.of(boxContext).pop();
                                },
                                child: const Text("completed"));
                          } else {
                            return Container();
                          }
                        })(),
                        // DELETE BUTTON DISPLAYED FOR ADMINS ONLY
                        (() {
                          if (MyApp.accountType == "admin") {
                            return ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.red)),
                                onPressed: () {
                                  deleteOrder(index);
                                  Navigator.of(boxContext).pop();
                                },
                                child: Text("delete"));
                          } else {
                            return Container();
                          }
                        })(),
                      ]),
                )
              ],
            );
          });
    }

    return (Container(
        margin: EdgeInsets.only(top: 20),
        width: screenWidth * 0.9,
        child: Container(
            height: screenHeight - 250,
            child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        handleSelect(index);
                      },
                      child: Order(
                          address: orders[index]["address"],
                          give: orders[index]["give"],
                          returning: orders[index]["returning"],
                          status: orders[index]["status"]));
                }))));
  }
}
