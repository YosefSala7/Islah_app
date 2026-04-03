import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final Widget child;

  const MyCard(
    this.borderRadius,
    this.height,
    this.width,
    this.backgroundColor,
    this.child, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
