import 'package:flutter/material.dart';

final login_button = Container(
  padding: EdgeInsets.symmetric(vertical: 25.0),
  width: double.infinity,
  child: RaisedButton(
    elevation: 5.0,
    onPressed: () => print('Login Button Pressed'),
    padding: EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    color: Colors.white,
    child: Text(
      'LOGIN',
      style: TextStyle(
        color: Color(0xFFff5252),
        letterSpacing: 1.5,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    ),
  ),
);
