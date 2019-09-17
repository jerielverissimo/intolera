import 'package:flutter/material.dart';
import '../utilities/styles.dart';

final sign_with_text = Column(
  children: <Widget>[
    Text(
      '-- OR --',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
    SizedBox(height: 20.0),
    Text('Sign in with', style: kLabelStyle),
  ],
);
