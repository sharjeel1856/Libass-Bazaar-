import 'package:flutter/material.dart';
import 'package:olx_clone/ForgetPassword/body.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ForgetBody(),
    );
  }
}
