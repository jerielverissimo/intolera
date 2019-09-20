import 'package:flutter/material.dart';
import '../utilities/styles.dart';

final email_input_text = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Text(
      'Email',
      style: kLabelStyle,
    ),
    SizedBox(height: 10.0),
    Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black54,
          ),
          hintText: 'Enter your Email',
          hintStyle: kHintTextStyle,
        ),
      ),
    ),
  ],
);
