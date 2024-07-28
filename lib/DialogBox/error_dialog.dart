import 'package:flutter/material.dart';
import 'package:olx_clone/WelcomeScreen/welcome_screen.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  const ErrorAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      backgroundColor: Colors.teal, // Set background color to teal
      content: Text(
        message,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Button background color
            onPrimary: Colors.teal, // Button text color
          ),
          child: const Center(
            child: Text('OK'),
          ),
        ),
      ],
    );
  }
}
