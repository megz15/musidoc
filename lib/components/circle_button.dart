import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final Color color;
  final String text;
  final double radius;
  const CircleButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.radius})
      : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    //Color colour = widget.color;
    return Container(
        width: widget.radius,
        height: widget.radius,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.color,
        ),
        child: Center(child: Text(widget.text)));
  }
}
