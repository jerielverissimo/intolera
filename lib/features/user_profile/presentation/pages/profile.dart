import 'package:flutter/material.dart';
import 'package:intolera/core/authentication/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'User Profile',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
