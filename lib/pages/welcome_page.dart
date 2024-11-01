import 'package:flutter/material.dart';
import 'package:travel_app/pages/MainScreen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add gradient background here
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Match other page backgrounds
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(),

                  // Image Section with some spacing adjustments
                  Image.asset(
                    'assets/logoe.png',
                    height: 180, // Adjust height for better layout
                  ),

                  const SizedBox(height: 40),

                  // Main Welcome Text
                  const Text(
                    "Welcome to \nTunisair Mobile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28, // Slightly larger for emphasis
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White for good contrast
                      height: 1.4, // Adjust line height for better readability
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle Text
                  const Text(
                    "Your gateway to seamless travel and exclusive Fidelys benefits right at your fingertips.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70, // Subtle white for softer contrast
                      fontSize: 16,
                      height: 1.5, // Increased line height for easier reading
                    ),
                  ),

                  const Spacer(),

                  // Button Section
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40), // More space at the bottom
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(), // Rounded button for modern look
                          padding: const EdgeInsets.symmetric(
                            vertical: 18, // Larger vertical padding for a premium feel
                            horizontal: 16,
                          ),
                          backgroundColor: const Color(0xFF00506A), // Matching theme color
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 18, // Slightly larger font size for readability
                            fontWeight: FontWeight.bold, // Bold for emphasis
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
