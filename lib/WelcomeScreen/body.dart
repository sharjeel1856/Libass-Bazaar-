import 'package:flutter/material.dart';
import 'package:olx_clone/LoginScreen/login_screen.dart';
import 'package:olx_clone/SignupScreen/signup_screen.dart';
import 'package:olx_clone/WelcomeScreen/background.dart';
import 'package:olx_clone/Widgets/rounded_button.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WelcomeBackground(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Libass Bazaar',
            style: TextStyle(
                fontSize: 46.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(
            height: 1.0,
          ),
          Image.asset(
            'assets/icons/chat.png',
            height: 300.0,
          ),
          RoundedButton(
            text: 'LOGIN',
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          SizedBox(
            height: 9.0,
          ),
          RoundedButton(
            text: 'SIGNUP',
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          ),
        ],
      ),
    ));
  }
}
