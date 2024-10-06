import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/LoginController.dart';

class MonyPage extends StatefulWidget {
  @override
  _MonyPageState createState() => _MonyPageState();
}

class _MonyPageState extends State<MonyPage> {
  void _submit() {
    // For demonstration, showing the data in a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submitted Data'),
          content: Text('First Field: \nSecond Field: '),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Convert your miles'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " you have",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  " ${c.miles.value}",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  " miles",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text('')
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
                "if u want to convert your bonus miles to qualifying miles",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  ),
),
            SizedBox(height: 10),
            Text(
              " Click Submit",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              " (  1 mile prime = 0.6 mile qualifiant  )",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                c.convertFunction();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
