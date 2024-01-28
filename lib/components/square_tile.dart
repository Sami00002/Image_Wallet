import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  // Declaration of a variable to hold the path of the image
  final String imagePath;
  // Constructor for the SquareTile class
  const SquareTile({
    super.key,
    required this.imagePath, // This is a required parameter for the imagePath
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20), // Adding padding around the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Making the corners rounded
        color: Colors.grey[200], // Setting the background color of the tile
      ),
      child: Image.asset(
        imagePath, // Displaying the image from the provided path
        height: 40,
        ),
    );
  }
}