import 'package:flutter/material.dart';

// Custom text field widget for uniform text fields across the app
// Controller to manage the text input
class MyTextField extends StatelessWidget {
   final controller;
   // Hint text to show when the field is empty
   final String hintText;
   // Whether the text should be obscured (for passwordsÖ
   final bool obscureText;
   
   // Constructor with required fields
   const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,// Constructor with required fields
    required this.obscureText,
    });


  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   // TextField widget for user input
                  child: TextField(
                  // Associates the provided controller with the text field
                    controller: controller,
                    obscureText: obscureText,
                    // Defines the appearance and style of the text field
                    decoration: InputDecoration(
                    // Style for the border when the text field is not in focus
                      enabledBorder: const OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.white),
                      ),
                      // Style for the border when the text field is in focus
                      focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      // Text to display when the field is empty
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                );
  }
}