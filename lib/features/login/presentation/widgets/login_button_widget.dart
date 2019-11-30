import 'package:flutter/material.dart';
import '../../../../core/presentation/utilities/styles.dart';
import '../../../dashboard/presentation/pages/dashboard_screen.dart';
import 'package:intolera/core/authentication/firebase_auth.dart';

class LoginButton extends StatelessWidget {
  final String _email;
  final String _password;

  LoginButton(this._email, this._password);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          bool res = await AuthProvider().signInWithEmail(_email, _password);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: alertColor,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
