import 'package:flutter/material.dart';

class AlreadyHaveANAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  AlreadyHaveANAccountCheck(
      {this.login = true, required this.press, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Do not have an Account?' : 'Already have an Account!',
          style: const TextStyle(
            color: Colors.black54,
            fontStyle: FontStyle.normal,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? '  Sign Up' : ' Sign In',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
