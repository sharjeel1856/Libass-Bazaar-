import 'package:flutter/material.dart';
import 'package:olx_clone/Widgets/text_feild_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  RoundedPasswordField({required this.onChanged});

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscureText = true; // Moved inside the state class

  @override
  Widget build(BuildContext context) {
    return TextFeildContainer(
      child: TextFormField(
        obscureText: obscureText, // Use local variable obscureText
        onChanged: widget.onChanged,
        cursorColor: Colors.teal,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.teal,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
          ), // Removed extra closing parenthesis
          border: InputBorder.none,
        ),
      ),
    );
  }
}
