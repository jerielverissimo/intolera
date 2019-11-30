import 'package:flutter/material.dart';
import '../utilities/styles.dart';

class RememberMeCheckboxWidget {
  final Function stateSetter;
  final rememberMe;

  RememberMeCheckboxWidget(this.stateSetter, this.rememberMe);

  Widget buildRemeberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: this.stateSetter,
            ),
          ),
          Text(
            'Lembrar de mim',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }
}
