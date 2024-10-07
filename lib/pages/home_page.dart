import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/widgets/custom_icon_button.dart';
import 'package:travel_app/widgets/location_card.dart';
import 'package:travel_app/widgets/nearby_places.dart';
import 'package:travel_app/widgets/recommended_places.dart';
import 'package:travel_app/widgets/tourist_places.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            children: [
              // Custom AppBar Section
              _buildAppBar(context),
              const SizedBox(height: 20),

              // Location Card with shadow for depth
              const LocationCard(),
              const SizedBox(height: 20),

              // Tourist Places Section
              const TouristPlaces(),
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
        ),
      ),
    );
  }

  // Custom AppBar with a modern look
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tunisair Mobile",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Discover your next adventure",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/profile_image.png'), // Add user profile image
          ),
        ],
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
            "See All",
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
