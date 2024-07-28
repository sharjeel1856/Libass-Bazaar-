import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/DialogBox/error_dialog.dart';
import 'package:olx_clone/DialogBox/loading_dialog.dart';
import 'package:olx_clone/ForgetPassword/forget_password.dart';
import 'package:olx_clone/HomeScreen/home_screen.dart';
import 'package:olx_clone/LoginScreen/background.dart';
import 'package:olx_clone/SignupScreen/signup_screen.dart';
import 'package:olx_clone/Widgets/already_have_an_account_check.dart';
import 'package:olx_clone/Widgets/rounded_password_feild.dart';
import 'package:olx_clone/Widgets/rounede_input_feild.dart';

import '../Widgets/rounded_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth
      .instance; // if user is created account then just login to the app
  void _login() async {
    showDialog(
        context: context,
        builder: (_) {
          return LoadingAlertDialog(
            message: 'Please wait',
          );
        });
    //if user have SIGN UP then just login to the app
    User? currentUser;

    await _auth
        .signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });
    //if not login then then show error message
    if (currentUser != null) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.04,
          ),
          Image.asset(
            'assets/icons/login.png',
            height: size.height * 0.32,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputFeild(
            hintText: 'Email',
            icon: Icons.person,
            onChanged: (value) {
              _emailController.text = value;
            },
          ),
          SizedBox(
            height: 6,
          ),
          RoundedPasswordField(
            onChanged: (value) {
              _passwordController.text = value;
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgetPassword()));
              },
              //yeh issue a raha hai yahan pai ok
              //jis scrfeen mein issue hai woh code
              child: const Center(
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      decorationThickness: 4.0),
                ),
              ),
            ),
          ),
          RoundedButton(
            text: 'LOGIN',
            press: () {
              _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty
                  ? _login()
                  : showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorAlertDialog(
                            message: 'Please write email & password for Login');
                      });
            },
          ),
          SizedBox(
            height: 8,
          ),
          AlreadyHaveANAccountCheck(
            login: true,
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )
        ],
      ),
    ));
  }
}
