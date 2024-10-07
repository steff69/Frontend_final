import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/VoleMainController.dart';

class TravelFormScreen extends StatefulWidget {
  @override
  _TravelFormScreenState createState() => _TravelFormScreenState();
}

class _TravelFormScreenState extends State<TravelFormScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  int selectedAdults = 1;

  @override
  Widget build(BuildContext context) {
    var c = Get.put(VoleMainController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4F739E), // Red background
        title: Text(
          "Search flight",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Image with convex corners and shadow, no margin
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 4), // Soft shadow effect
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), // Convex corner left
                bottomRight: Radius.circular(40), // Convex corner right
              ),
              child: Image.asset(
                'assets/t.jpg',
                height: 200.h,
                width: double.infinity, // Full width
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 'From' Section
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF002C3E),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            TextField(
                              controller: fromController,
                              decoration: InputDecoration(
                                labelText: "Enter starting location",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 'To' Section
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF002C3E),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            TextField(
                              controller: toController,
                              decoration: InputDecoration(
                                labelText: "Enter destination",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Dropdown for selecting number of adults
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Adults",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF002C3E),
                              ),
                            ),
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
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Submit Button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF002C3E),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          c.searchVoleMainFunction(
                              fromController.text, toController.text);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
