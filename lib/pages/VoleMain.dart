import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/VoleMainController.dart';

class TravelFormScreen extends StatefulWidget {
  @override
  _TravelFormScreenState createState() => _TravelFormScreenState();
}

class _TravelFormScreenState extends State<TravelFormScreen> {
  // Controllers for the text fields
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  // Variable to store the selected number of adults
  int selectedAdults = 1;

  // This function will handle form submission
  void submitForm() {
    final fromLocation = fromController.text;
    final toLocation = toController.text;

    // Print values for now
    print("From: $fromLocation");
    print("To: $toLocation");
    print("Adults: $selectedAdults");

    // Show the data in a dialog
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(VoleMainController());

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text("Travel Planner"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Image.asset('assets/t.jpg'),
              SizedBox(
                height: 35.h,
              ),
              // 'From' TextField
              TextField(
                controller: fromController,
                decoration: InputDecoration(
                  labelText: "From",
                  hintText: "Enter starting location",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),

              // 'To' TextField
              TextField(
                controller: toController,
                decoration: InputDecoration(
                  labelText: "To",
                  hintText: "Enter destination",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),

              // Dropdown for selecting number of adults
              Row(
                children: [
                  Text(
                    "Adults: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<int>(
                    value: selectedAdults,
                    items: [
                      DropdownMenuItem(value: 1, child: Text("1")),
                      DropdownMenuItem(value: 2, child: Text("2")),
                      DropdownMenuItem(value: 3, child: Text("3")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedAdults = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  c.searchVoleMainFunction(
                      fromController.text, toController.text);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
