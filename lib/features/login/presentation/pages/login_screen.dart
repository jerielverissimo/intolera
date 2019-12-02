import 'package:flutter/material.dart';
import '../../../../core/presentation/utilities/styles.dart';
import '../widgets/email_input_text_widget.dart';
import '../widgets/password_input_widget.dart';
import '../widgets/login_button_widget.dart';
import '../widgets/social_button_row_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

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
                    EmailInputText(_emailController),
                    SizedBox(height: 30.0),
                    PasswordInput(_passwordController),
                    LoginButton(
                        _emailController.text, _passwordController.text),
                    social_button_row
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
