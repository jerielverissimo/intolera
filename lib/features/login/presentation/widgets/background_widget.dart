import 'package:flutter/material.dart';
import './bubble_widget.dart';

const pink = Color(0xffff4081);
const orange = Color(0xffffab40);

Container buildBackground() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffff80ab), Color(0xffffab40)])),
    child: Stack(
      children: <Widget>[
        buildBubble(Color(0xffffab40), Color(0xffe91e63),
            top: 300.0,
            left: -100,
            width: 300,
            height: 300,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
        buildBubble(orange, pink,
            top: 50.0,
            left: 50,
            width: 50,
            height: 50,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [.0, .8]),
        buildBubble(pink, orange,
            bottom: 200,
            left: 75,
            width: 35,
            height: 35,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        buildBubble(pink, orange,
            bottom: 45,
            right: 75,
            width: 75,
            height: 75,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        buildBubble(pink, orange,
            top: 250,
            right: -50,
            width: 100,
            height: 100,
            stops: [0, 1],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
        buildBubble(pink, orange,
            top: -50,
            right: 50,
            width: 150,
            height: 150,
            stops: [0, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter),
      ],
    ),
  );
}
