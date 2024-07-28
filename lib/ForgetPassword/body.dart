import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/DialogBox/error_dialog.dart';
import 'package:olx_clone/ForgetPassword/background.dart';
import 'package:olx_clone/LoginScreen/login_screen.dart';

class ForgetBody extends StatefulWidget {
  const ForgetBody({super.key});

  @override
  State<ForgetBody> createState() => _ForgetBodyState();
}

class _ForgetBodyState extends State<ForgetBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _forgetPassTextController =
      TextEditingController(text: '');

  void _forgetPassSubmitForm() async {
    try {
      await _auth.sendPasswordResetEmail(
        email: _forgetPassTextController.text,
      );
      _showSuccessDialog();
    } catch (error) {
      ErrorAlertDialog(
        message: error.toString(),
      );
    }
  }

  // Alert box to show message to the user that the email is send to them
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal,
          title: const Text(
            'Email Sent',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'An email has been sent to reset your password.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ForgetBackground(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Image(
                  image: AssetImage('assets/images/forgot.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Enter Email address to Reset Password!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _forgetPassTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.5,
                    child: MaterialButton(
                      onPressed: () {
                        _forgetPassSubmitForm();
                      },
                      color: Colors.black,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Reset Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
