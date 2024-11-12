import 'package:flutter/material.dart';

class Distance extends StatelessWidget {
  const Distance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Discover !\nTop tourist destinations",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16, // Increase font size to make it bigger
            fontWeight: FontWeight.bold, // Optional: make it bold
          ),
        ),
        const SizedBox(width: 2),
      ],
    );
  }
}
