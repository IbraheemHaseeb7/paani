import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:paani/Components/CreateForm/CustomInput.dart';
import '../../main.dart';
import '../ActiveOrders/Order.dart';

class DeliveringOrders extends StatefulWidget {
  @override
  DeliveringOrdersState createState() => DeliveringOrdersState();
}

class DeliveringOrdersState extends State<DeliveringOrders> {
  List<Map<String, dynamic>> orders = [];
  bool isFetched = false;

  void getOrders() async {
    const url =
        'https://paani-api.netlify.app/.netlify/functions/api/query'; // Replace with your API endpoint URL
    String query =
        "select (select [address] from Clients c where c.cid=od.cid) as [address], (select [name] from Riders r where r.rid=od.rid) as [Rider Name], [send], [receive], o.[status], [Amount Paid], (select [name] from Clients c where c.cid=od.cid) as [name], o.[oid], [Due Time]  from [Orders] o inner join [Orders Details] od on od.oid=o.oid inner join [Riders] r on r.rid=od.rid where r.rid='R1' and o.[Company ID]='CP1' and o.[status] in ('active', 'delivering') order by case when o.[status]='delivering' then 1  when o.[status]='active' then 2 when o.[status]='completed' then 3 end";

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

  DeliveringOrdersState() {
    getOrders();
  }

  void refresh() {
    setState(() {
      orders = [];
    });
    getOrders();
  }

  Map<String, String> inputs = {};

  void setSelection(String name, String? value) {
    inputs[name] = value ?? "";
  }

  void handleCompletion(String id) async {
    if (inputs["received"] != "" && inputs["received"] != null) {
      const url =
          'https://paani-api.netlify.app/.netlify/functions/api/update'; // Replace with your API endpoint URL

      final headers = {'Content-Type': 'application/json'};
      final body = {
        'query':
            "update Orders set [status]='completed', [Amount Received]=${inputs["received"]} where oid='$id'"
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      Fluttertoast.showToast(
          msg: "Successfully Completed an Order",
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          webBgColor: "#2196F3",
          backgroundColor: Color(0xFF2196F3));

      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void handleSelect(int index) {
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text(
                "Complete the order",
                style: TextStyle(color: Colors.blue),
              ),
              content: Container(
                height: 200,
                width: screenWidth - 100,
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Name: ${orders[index]["name"]}",
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Amount to receive: ${orders[index]["amount"]}",
                        )),
                    CustomInput(
                        setSelection: setSelection,
                        name: "received",
                        label: "Amount Received",
                        icon: Icon(Icons.money),
                        size: screenWidth - 150),
                    Container(
                      width: screenWidth - 150,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            handleCompletion(orders[index]["id"]);
                            Navigator.of(context).pop();
                          },
                          child: const Text("completed")),
                    )
                  ],
                ),
              ),
            );
          });
    }

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
