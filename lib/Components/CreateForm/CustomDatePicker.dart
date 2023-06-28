import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  Function(String, String?) setSelection;
  CustomDatePicker({super.key, required this.setSelection});

  @override
  Widget build(BuildContext context) {
    // HELPING VARIABLES
    double? screenWidth = MediaQuery.of(context).size.width;
    TextEditingController tec = TextEditingController();

    return (Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: screenWidth * 0.8,
        child: TextField(
          controller: tec,
          //editing controller of this TextField
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
              hintText: "Date"),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2200));

            if (pickedDate != null) {
              String day = pickedDate.day.toString();
              String month = pickedDate.month.toString();
              String year = pickedDate.year.toString();
              tec.text = year + "-" + month + "-" + day;

              setSelection("date", tec.text);
            }
          },
        )));
  }
}
