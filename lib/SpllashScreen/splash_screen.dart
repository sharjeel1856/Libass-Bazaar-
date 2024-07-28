import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/HomeScreen/home_screen.dart';
import 'package:olx_clone/WelcomeScreen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(Duration(seconds: 5), () async {
      //if user is logined
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        //if not login then go to the Welcome screen first
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              width: 350.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Center(
              child: Text(
                'Sell, Purchase or Exchange '
                'your Old Home Applications',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
