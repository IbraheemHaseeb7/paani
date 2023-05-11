import 'package:flutter/material.dart';
import 'package:paani/Components/ActiveOrders/OrderStatusContainer.dart';

class Order extends StatefulWidget {
  String? address;
  String? give, returning, status;
  Order(
      {super.key,
      required this.address,
      required this.give,
      required this.returning,
      required this.status});

  @override
  OrderState createState() => OrderState();
}

class OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return (Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(132, 33, 149, 243),
            borderRadius: BorderRadius.circular(5)),
        width: screenWidth * 0.8,
        margin: EdgeInsets.only(bottom: 10),
        height: 50,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(),
                width: 120,
                child: Text(
                  widget.address!,
                  style: TextStyle(color: Colors.white),
                )),
            OrderStatusContainer(
              give: widget.give!,
              returning: widget.returning!,
              status: widget.status!,
            )
          ],
        )));
  }
}
