import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/pages/VoleMain.dart'; // Make sure to import the VoleMain.dart file

class TouristDetailsPage extends StatefulWidget {
  const TouristDetailsPage({
    Key? key,
    required this.image,
    required this.name,
    required this.descirption,
  }) : super(key: key);

  final String image;
  final String name;
  final String descirption;

  @override
  _TouristDetailsPageState createState() => _TouristDetailsPageState();
}

class _TouristDetailsPageState extends State<TouristDetailsPage> {
  bool isFavorite = false; // Variable to track if heart is clicked

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  SizedBox(
                    height: size.height * 0.38,
                    width: double.maxFinite,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  iconSize: 20,
                                  icon: const Icon(Ionicons.chevron_back),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite; // Toggle favorite state
                                    });
                                  },
                                  icon: Icon(
                                    Ionicons.heart,
                                    color: isFavorite ? Colors.red : Colors.black54, // Change color based on state
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "4",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Icon(
                            Ionicons.star,
                            color: Colors.yellow[800],
                            size: 15,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 10),
                  Text(
                    widget.descirption,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to TravelFormScreen on button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TravelFormScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 8.0,
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text(
                  "Grab Your Seat Now!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
