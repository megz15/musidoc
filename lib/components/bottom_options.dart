import 'package:flutter/material.dart';

class BottomOptions extends StatefulWidget {
  final double boxBlurRadius;
  final int? dropDownValue;
  final List<int>? listOfDropDownValues;
  final void Function()? onMinusTap;
  final void Function()? onPlusTap;
  final void Function(String?)? onDropdownChange;
  const BottomOptions(
      {Key? key,
        this.boxBlurRadius = 0,
      this.dropDownValue,
        this.listOfDropDownValues,
      this.onDropdownChange,
      this.onMinusTap,
      this.onPlusTap})
      : super(key: key);

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
            DropdownButton<String>(
              value: widget.dropDownValue.toString(),
              items: (widget.listOfDropDownValues ?? [20, 10, 7, 5, 3, 2, 1])
                  .map((int value) {
                return DropdownMenuItem(
                  value: value.toString(),
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
