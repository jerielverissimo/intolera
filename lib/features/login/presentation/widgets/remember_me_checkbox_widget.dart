import 'package:flutter/material.dart';
import '../utilities/styles.dart';


  Widget buildRemeberMeCheckbox(Function switchState) {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: false,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: switchState(),
            ),
          ),
          Text(
            'Remember Me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }