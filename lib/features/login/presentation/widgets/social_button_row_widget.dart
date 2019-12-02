import 'package:flutter/material.dart';
import 'package:intolera/core/authentication/firebase_auth.dart';
import './social_button_widget.dart';

final social_button_row = Padding(
  padding: EdgeInsets.symmetric(vertical: 30.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      buildSocialBtn(
        () async {
          bool res = await AuthProvider().loginWithGoogle();
          if (!res) print("Error loggin in with google");
        },
        AssetImage('assets/logos/google.jpg'),
      ),
    ],
  ),
);
