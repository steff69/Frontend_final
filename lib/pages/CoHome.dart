import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/widgets/location_card.dart';
import 'package:travel_app/widgets/nearby_places.dart';
import 'package:travel_app/widgets/recommended_places.dart';
import 'package:travel_app/widgets/tourist_places.dart';

class CoHome extends StatelessWidget {
  const CoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set gradient background to give a modern look
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(14),
                children: [
                  const SizedBox(height: 60), // Add space for the back button

                  // Location Card with shadow for depth
                  const LocationCard(),
                  const SizedBox(height: 20),

                  // Recommendation Section
                  _buildSectionTitle("Recommendation", context),
                  const SizedBox(height: 10),
                  const RecommendedPlaces(),
                  const SizedBox(height: 20),

                  // Nearby Places Section
                  _buildSectionTitle("Nearby From You", context),
                  const SizedBox(height: 10),
                  NearbyPlaces(),
                  const SizedBox(height: 30), // Add extra space at the end
                ],
              ),

              // Custom Back Button
              Positioned(
                top: 20,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the button
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Ionicons.chevron_back,
                      color: Colors.black54, // Icon color
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Section Title
  Widget _buildSectionTitle(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Implement your 'See All' functionality here
          },
          child: Text(
            "",
            style: TextStyle(
              color: Colors.lightBlueAccent.shade100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
