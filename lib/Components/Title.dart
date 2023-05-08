import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double? screenWidth = MediaQuery.of(context).size.width;

    return (Container(
      width: screenWidth * 0.8,
      child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),
    ));
  }
}
