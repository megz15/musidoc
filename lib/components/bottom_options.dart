import 'package:flutter/material.dart';

class BottomOptions extends StatefulWidget {
  final double boxBlurRadius;
  final int dropDownValue;
  final List<int>? listOfDropDownValues;
  final void Function()? onMinusTap;
  final void Function()? onPlusTap;
  final void Function(int?)? onDropdownChange;
  const BottomOptions({
    Key? key,
    this.boxBlurRadius = 10,
    this.dropDownValue = 5,
    this.listOfDropDownValues = const [5, 4, 3, 2, 1],
    this.onDropdownChange,
    this.onMinusTap,
    this.onPlusTap,
  }) : super(key: key);

  @override
  State<BottomOptions> createState() => _BottomOptionsState();
}

class _BottomOptionsState extends State<BottomOptions> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: widget.boxBlurRadius,
              color: Colors.blue,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                iconSize: 30,
                onPressed: widget.onMinusTap,
                icon: Icon(Icons.remove_circle),
                color: Colors.red),
            DropdownButton<int>(
              value: widget.dropDownValue,
              items: (widget.listOfDropDownValues!).map((int value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: widget.onDropdownChange,
            ),
            IconButton(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                iconSize: 30,
                onPressed: widget.onPlusTap,
                icon: Icon(Icons.add_circle),
                color: Colors.green),
          ],
        ),
      ),
    );
  }
}
