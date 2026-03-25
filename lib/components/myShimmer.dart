import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class MyShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double hight;
  final double width;

  const MyShimmer({super.key, this.isLoading = true,required this.hight, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Shimmer.fromColors(
      loop: 0,
      baseColor:
          Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(200) ??
          Colors.grey[300]!,
      highlightColor: Theme.of(context).colorScheme.secondary.withAlpha(200),
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: hight,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:
              Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(200) ??
              Colors.grey[300]!,
        ),
      ),
    );
  }
}
