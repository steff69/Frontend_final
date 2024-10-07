import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/VoleMainController.dart';

class TravelFormScreen extends StatefulWidget {
  @override
  _TravelFormScreenState createState() => _TravelFormScreenState();
}

class _TravelFormScreenState extends State<TravelFormScreen> {
  String? selectedFromLocation = 'France'; // Default value for From
  String? selectedToLocation = 'Italy'; // Default value for To
  int selectedAdults = 1;
  String? selectedTripType = 'One Way'; // Default value for Trip Type

  @override
  Widget build(BuildContext context) {
    var c = Get.put(VoleMainController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4F739E),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image with convex corners and shadow
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
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    'assets/cen.png',
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Add more space between the image and the quote
              SizedBox(height: 40.h), // Increased the height here

              // Add the motivational quote
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Let your dreams take flight',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300, // Light weight to give it a "quote" feel
                  ),
                ),
              ),

              // Add space between the quote and the dropdowns
              SizedBox(height: 20.h),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 'From' Dropdown Section
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
                            DropdownButtonFormField<String>(
                              value: selectedFromLocation,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey, // Visible border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border on focus
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: ['France', 'Italy', 'Tunisia']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedFromLocation = value!;
                                });
                              },
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 'To' Dropdown Section (Now below 'From')
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
                            DropdownButtonFormField<String>(
                              value: selectedToLocation,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey, // Visible border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border on focus
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: ['France', 'Italy', 'Tunisia']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedToLocation = value!;
                                });
                              },
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Row for 'Adults' and 'Trip Type'
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center both widgets
                      children: [
                        // Adults Dropdown
                        Expanded(
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0), // Smaller padding
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // To make the card small
                                children: [
                                  Text(
                                    "Adults",
                                    style: TextStyle(
                                      fontSize: 14.sp, // Smaller font size
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF002C3E),
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // Space between text and dropdown
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
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black), // Smaller dropdown text
                                    dropdownColor: Colors.white, // Dropdown background color
                                    underline: SizedBox(), // Removes underline
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // Trip Type Dropdown
                        Expanded(
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0), // Smaller padding
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Type",
                                    style: TextStyle(
                                      fontSize: 14.sp, // Same size as Adults
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF002C3E),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  DropdownButton<String>(
                                    value: selectedTripType,
                                    items: [
                                      DropdownMenuItem(
                                          value: 'One Way', child: Text("One Way")),
                                      DropdownMenuItem(
                                          value: 'Round Trip', child: Text("Round Trip")),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTripType = value!;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black), // Same size
                                    dropdownColor: Colors.white, // Dropdown background color
                                    underline: SizedBox(), // Removes underline
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // Submit Button
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h), // Added more space to prevent overlap
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
                                selectedFromLocation!, selectedToLocation!);
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
