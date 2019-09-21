import 'package:flutter/material.dart';
import '../../../core/presentation/utilities/styles.dart';
import '../widgets/email_input_text_widget.dart';
import '../widgets/password_input_widget.dart';
import '../widgets/login_button_widget.dart';
import '../widgets/forgot_password_button_widget.dart';
import '../widgets/remember_me_checkbox_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool _rememberMe = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              color: primaryColor,
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    email_input_text,
                    SizedBox(height: 30.0),
                    password_input,
                    forgot_password_button_widget,
                    RememberMeCheckboxWidget((value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    }, _rememberMe)
                        .buildRemeberMeCheckbox(),
                    LoginButton(),
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
