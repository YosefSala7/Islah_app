import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.title,required this.themeData});

  final String title;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      delegate: _FadingAppBarDelegate(
        themeData: themeData,
        title: title,
        minHeight: kToolbarHeight,
        maxHeight: 70.0,
      ),
    );
  }
}

class _FadingAppBarDelegate extends SliverPersistentHeaderDelegate {
  _FadingAppBarDelegate({
    required this.title,
    required this.minHeight,
    required this.maxHeight,
    required this.themeData, 
  });

  final String title;
  final double minHeight;
  final double maxHeight;
  final ThemeData themeData;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double opacity = (1 - (shrinkOffset / (maxHeight - minHeight))).clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Text(
          title,
          style: themeData.textTheme.bodyLarge?.copyWith( 
                fontFamily: "ReemKufi",
                fontSize: 35,
                fontWeight: FontWeight.normal
              ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _FadingAppBarDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.themeData != themeData;
  }
}