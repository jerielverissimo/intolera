import 'package:flutter/material.dart';
import '../utilities/styles.dart';

final forgot_password_button_widget = Container(
  alignment: Alignment.centerRight,
  child: FlatButton(
    onPressed: () => print('Forgot Password Button Pressed'),
    padding: EdgeInsets.only(right: 0.0),
    child: Text(
      'Forgot Password',
      style: kLabelStyle,
    ),
  ),
);
