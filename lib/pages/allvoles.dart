import 'package:flutter/material.dart';
import 'package:travel_app/Models%202/voleModel.dart';
import 'package:travel_app/pages/MainScreen.dart';

class AllVolesPage extends StatelessWidget {
  AllVolesPage({super.key, required this.alldataList});
  List<FlightData> alldataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the AppBar shadow for a clean look
      ),
      extendBodyBehindAppBar: true, // Extend the gradient behind the app bar
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 80), // Space between header and label

            // Add the label for available trips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Choose Your Flight : ', // Change this text as needed
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24, // Font size for the label
                  fontWeight: FontWeight.bold, // Make the label bold
                  color: Colors.white, // White color for the label
                  letterSpacing: 1.2, // Slight letter spacing for style
                ),
              ),
            ),

            SizedBox(height: 20), // Space between label and the list of trips

            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                itemBuilder: (context, index) => FlightCard(item: alldataList[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: alldataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  FlightCard({super.key, required this.item});
  FlightData item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showReserveDialog(context);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flight date displayed above everything
              Text(
                item.date,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey, // Use a subtle color for the date
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Main flight information (Time, Airport)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeColumn(item.deptime ?? 'N/A', item.from),
                  _buildMiddleSection(),
                  _buildTimeColumn(item.arrtime ?? 'N/A', item.to),
                ],
              ),
              const SizedBox(height: 10),

              // Flight duration information
              Text(
                'Duration: ${item.time}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),

              // Price displayed at the bottom-right
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                children: [
                  Text(
                    ' \$${item.price} / person',
                    style: const TextStyle(
                      fontSize: 18, // Slightly larger for emphasis
                      color: Colors.indigo, // Matches the color for time and location
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the time and airport columns for the flight
  Widget _buildTimeColumn(String time, String airport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          airport,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Builds the middle section with the flight path and "nonstop" tag
  Widget _buildMiddleSection() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.flight_takeoff, color: Colors.grey, size: 16),
            const SizedBox(width: 5),
            const Text(
              'Nonstop',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Icon(Icons.flight_land, color: Colors.grey, size: 16),
          ],
        ),
        const SizedBox(height: 5),
        const SizedBox(
          width: 100,
          child: Divider(
            thickness: 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _showReserveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reserve Flight'),
          content: const Text('Do you want to reserve this flight?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Reserve'),
              onPressed: () {
                Navigator.of(context).pop();
                // Add reservation logic here
              },
            ),
          ],
        );
      },
    );
  }
}
