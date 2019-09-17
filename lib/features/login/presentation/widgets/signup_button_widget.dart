import 'package:flutter/material.dart';

final signup_button = GestureDetector(
  onTap: () => print('Sign Up Button Pressed'),
  child: RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Don\'t have an account yet? ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: 'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
);
