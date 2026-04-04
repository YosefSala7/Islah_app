import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:flutter/material.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height:
                MediaQuery.heightOf(context) -
                MediaQuery.heightOf(context) / 9,
            child: QuranIndexScreen(),
          ),
        ],
      ),
    );
  }
}
