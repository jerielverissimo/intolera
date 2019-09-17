import 'package:flutter/material.dart';
import './social_button_widget.dart';

final social_button_row = Padding(
  padding: EdgeInsets.symmetric(vertical: 30.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      buildSocialBtn(
        () => print('Login with Facebook'),
        AssetImage('assets/logos/facebook.jpg'),
      ),
      buildSocialBtn(
        () => print('Login with Google'),
        AssetImage('assets/logos/google.jpg'),
      ),
    ],
  ),
);
