import 'package:flutter/material.dart';

Positioned buildBubble(Color first, Color second,
    {double top,
    double left,
    double bottom,
    double right,
    double width,
    double height,
    Alignment begin,
    Alignment end,
    List<double> stops}) {
  return Positioned(
    top: top,
    left: left,
    bottom: bottom,
    right: right,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: [first, second])),
    ),
  );
}
