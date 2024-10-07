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
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemBuilder: (context, index) => FlightCard(item: alldataList[index]),
        separatorBuilder: (context, index) =>
        const SizedBox(height: 10), // Add space between the cards
        itemCount: alldataList.length,
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
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.grey.shade400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flight date (only displayed once above everything)
              Text(
                item.date,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.indigo, // Same color as the others
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
              Center(
                child: Text(
                  'Duration: ${item.time}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Price displayed at the bottom-right
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                children: [
                  Text(
                    ' \$${item.price} / person',  // Adjusted the price format here
                    style: const TextStyle(
                      fontSize: 18, // Slightly larger for emphasis
                      color: Colors.indigo, // Now matches the color for "from" and "to"
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
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }

  // Builds the middle section with the flight path and "nonstop" tag
  Widget _buildMiddleSection() {
    return Column(
      children: [
        const SizedBox(
          width: 100,
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'nonstop',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const SizedBox(
          width: 100,
          child: Divider(
            thickness: 2,
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
