import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paani/Components/ActiveOrders/Order.dart';
import 'package:paani/main.dart';
import 'package:http/http.dart' as http;

class ActiveOrdersContainer extends StatefulWidget {
  @override
  ActiveOrdersContainerState createState() => ActiveOrdersContainerState();
}

class ActiveOrdersContainerState extends State<ActiveOrdersContainer> {
  List<Map<String, dynamic>> orders = [];
  bool isFetched = false;

  void getOrders() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/query'; // Replace with your API endpoint URL
    String query = "";

    if (MyApp.accountType == "admin") {
      query =
          "select (select [address] from Clients c where c.cid=od.cid) as [address], (select [name] from Riders r where r.rid=od.rid) as [Rider Name], [send], [receive], [status], [Amount Paid], (select [name] from Clients c where c.cid=od.cid) as [name], o.[oid], [Due Time]  from [Orders] o inner join [Orders Details] od on od.oid=o.oid where o.[Company ID]='${MyApp.companyID}' and o.[status] in ('active', 'delivering') order by case when [status]='delivering' then 1 when [status] ='active' then 2 when [status]='completed' then 3 end";
    } else {
      query =
          "select (select [address] from Clients c where c.cid=od.cid) as [address], [send], [receive], [status], [Amount Paid], (select [name] from Clients c where c.cid=od.cid) as [name], o.[oid], [Due Time]  from [Orders] o inner join [Orders Details] od on od.oid=o.oid where o.[Company ID]='${MyApp.companyID}' and o.[status]='active' and o.[status] in ('active', 'delivering') order by case when [status]='delivering' then 1 when [status]='active' then 2 when [status]='completed' then 3 end";
    }

    final headers = {'Content-Type': 'application/json'};
    final body = {'query': query};

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> temp = [];

      for (var e in data) {
        temp.add({
          "address": e["address"],
          "returning": e["receive"].toString(),
          "give": e["send"].toString(),
          "id": e["oid"],
          "name": e["name"],
          "status": e["status"],
          "amount": e["Amount Paid"].toString(),
          "date": e["Due Time"],
          "rider": e["Rider Name"]
        });
      }

      setState(() {
        orders = temp;
      });
    }

    isFetched = true;
  }

  ActiveOrdersContainerState() {
    getOrders();
  }

  void deleteOrder(int index) async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "update Orders set [status]='removed' where oid='${orders[index]["id"]}'"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    refresh();
  }

  void acceptOrder(String id) async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query':
          "begin tran update Orders set [status]='delivering' where oid='$id'; update [Orders Details] set [rid]='${MyApp.activeUser.id}' where oid='$id'; commit"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    refresh();
  }

  void refresh() {
    setState(() {
      orders = [];
    });
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (!isFetched) {
      return Container(
          width: screenWidth,
          height: screenHeight - 200,
          child: const Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ));
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
                                  acceptOrder(orders[index]["id"]);
                                  Navigator.of(boxContext).pop();
                                },
                                child: const Text("Accept"));
                          }
                          return Container();
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
