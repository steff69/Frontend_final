import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              'assets/map.png',
              width: 100,
            ),
            const SizedBox(width: 10),
            Column(
  crossAxisAlignment: CrossAxisAlignment.start, // Ensures the text starts from the left
  children: [
    Text(
      "Your Location",
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 16, // Adjust the size to your preference
            color: Theme.of(context).primaryColor,
          ),
    ),
    const SizedBox(height: 5),
    Text(
      "Tunis, Tunisia",
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 14, // Adjust the size to your preference
          ),
    )
  ],
)

          ],
        ),
      ),
    );
  }
}
