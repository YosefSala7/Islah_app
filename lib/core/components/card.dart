import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  double hight;
  double width;
  double bordeRadius;
  Color backgroundColor;
  Widget Content;

  MyCard(
    this.bordeRadius,
    this.hight,
    this.width,
    this.backgroundColor,
    this.Content, {super.key}
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(bordeRadius),
      ),
      child: Content,
    );
  }
}
