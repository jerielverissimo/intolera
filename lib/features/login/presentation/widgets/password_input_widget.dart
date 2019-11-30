import 'package:flutter/material.dart';
import '../utilities/styles.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController _passwordController;

  PasswordInput(this._passwordController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black54,
              ),
              hintText: 'Entra com sua Senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
