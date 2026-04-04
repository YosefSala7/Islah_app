import 'package:app/features/quran_feature/UI/juz_list.dart';
import 'package:app/features/quran_feature/UI/surah_list.dart';
import 'package:flutter/material.dart';

class QuranIndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            "المصحف الشريف",
            style: TextStyle(
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: "السور"),
              Tab(text: "الأجزاء"),
            ],
            indicatorColor: theme.colorScheme.secondary,
            indicatorWeight: 3,
            labelColor: theme.appBarTheme.foregroundColor,
            unselectedLabelColor: theme.appBarTheme.foregroundColor?.withAlpha(127),
            labelStyle: TextStyle(
              fontFamily: "Cairo",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Cairo",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SurahIndexList(),
            JuzIndexList(),
          ],
        ),
      ),
    );
  }
}