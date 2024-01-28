import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  
  // Declare a final Function that can be triggered when the button is tapped
  final Function()? onTap;
  
  // Constructor for MyButton, taking a key and the onTap function
  const MyButton({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector used for detecting and responding to touch events
      onTap: onTap,
      // The visual representation of the button
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        // Center widget to align the text inside the container
        child: const Center(
          // Text widget to display the button's label
          child: Text(
            "Sign in",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            )
          ),
      ),
    );
  }
}