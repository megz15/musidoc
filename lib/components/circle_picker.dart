import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class CirclePicker extends StatelessWidget {
  final List widgets;
  final double radius;
  const CirclePicker({Key? key, required this.widgets, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double blurRadius = 5;
    if (Platform.isLinux) blurRadius = 0;

    double r = radius / 2;
    double t = (2 * pi) / widgets.length;

    List<Widget> _circleElementsList() {
      List<Widget> list = [];
      for (int i = 0; i < widgets.length; i++) {
        list.add(
          Positioned(
            child: widgets[i],
            left: r * (1 + sin(t * i)),
            top: r * (1 - cos(t * i)),
          ),
        );
      }
      return list;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          width: radius,
          height: radius + 55,
          child: Stack(
            children: _circleElementsList(),
            /*children: [
              Positioned(
                  child: CircleButton(color: Colors.grey[200]!, text: 'S'),
                  top: r / 2 - r / 2 * sin(t * 3),
                  right: r / 2 - r / 2 * cos(t * 3)),
              Positioned(
                  child: CircleButton(color: Colors.grey[300]!, text: 'r'),
                  top: r / 2 - r / 2 * sin(t * 2),
                  right: r / 2 - r / 2 * cos(t * 2)),
              Positioned(
                  child: CircleButton(color: Colors.grey[400]!, text: 'R'),
                  top: r / 2 - r / 2 * sin(t),
                  right: r / 2 - r / 2 * cos(t)),
              Positioned(
                  child: CircleButton(color: Colors.grey, text: 'g'),
                  top: r / 2 - r / 2 * sin(t * 0),
                  right: r / 2 - r / 2 * cos(t * 0)),
              Positioned(
                  child: CircleButton(color: Colors.grey[400]!, text: 'G'),
                  top: r / 2 + r / 2 * sin(t),
                  right: r / 2 - r / 2 * cos(t)),
              Positioned(
                  child: CircleButton(color: Colors.grey[300]!, text: 'm'),
                  top: r / 2 + r / 2 * sin(t * 2),
                  right: r / 2 - r / 2 * cos(t * 2)),
              Positioned(
                  child: CircleButton(color: Colors.grey[200]!, text: 'M'),
                  top: r / 2 + r / 2 * sin(t * 3),
                  right: r / 2 + r / 2 * cos(t * 3)),
              Positioned(
                  child: CircleButton(color: Colors.grey[300]!, text: 'P'),
                  top: r / 2 + r / 2 * sin(t * 2),
                  right: r / 2 + r / 2 * cos(t * 2)),
              Positioned(
                  child: CircleButton(color: Colors.grey[400]!, text: 'd'),
                  top: r / 2 + r / 2 * sin(t),
                  right: r / 2 + r / 2 * cos(t)),
              Positioned(
                  child: CircleButton(color: Colors.grey, text: 'D'),
                  top: r / 2 - r / 2 * sin(t * 0),
                  right: r / 2 + r / 2 * cos(t * 0)),
              Positioned(
                  child: CircleButton(color: Colors.grey[400]!, text: 'n'),
                  top: r / 2 - r / 2 * sin(t),
                  right: r / 2 + r / 2 * cos(t)),
              Positioned(
                  child: CircleButton(color: Colors.grey[300]!, text: 'N'),
                  top: r / 2 - r / 2 * sin(t * 2),
                  right: r / 2 + r / 2 * cos(t * 2)),
            ],*/
          ),
        ),
      ),
    );
  }
}
