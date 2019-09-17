import 'package:flutter/material.dart';
import '../utilities/styles.dart';

final password_input = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text(
      'Password',
      style: kLabelStyle,
    ),
    SizedBox(height: 10.0),
    Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        obscureText: true,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Enter your Password',
          hintStyle: kHintTextStyle,
        ),
      ),
    ),
  ],
);
