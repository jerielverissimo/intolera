import 'package:flutter/material.dart';
import 'package:intolera/features/login/presentation/widgets/login_button_widget.dart';
import 'package:intolera/features/login/presentation/widgets/sign_with_text_widget.dart';
import 'package:intolera/features/login/presentation/widgets/social_button_row_widget.dart';
import '../widgets/email_input_text_widget.dart';
import '../widgets/forgot_password_button_widget.dart';
import '../widgets/password_input_widget.dart';
import '../widgets/remember_me_checkbox_widget.dart';
import '../widgets/signup_button_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFff4081),
                    Color(0xFFffab40),
                  ],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    email_input_text,
                    SizedBox(height: 30.0),
                    password_input,
                    forgot_password_button_widget,
                    RememberMeCheckboxWidget((value) {setState(() {
                          _rememberMe = value;
                    });}, _rememberMe).
                    buildRemeberMeCheckbox(),
                    login_button,
                    sign_with_text,
                    social_button_row,
                    signup_button,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
