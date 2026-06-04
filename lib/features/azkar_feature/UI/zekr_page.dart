import 'package:app/core/components/appBar.dart'; // لو هتحتاجه في مكان تاني
import 'package:app/features/azkar_feature/UI/finish_azkar.dart';
import 'package:app/features/azkar_feature/UI/zekr_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_azkar/islamic_azkar.dart';

class ZekrPage extends StatelessWidget {
  ZekrPage({super.key, required this.azkar, required this.category});
  final List azkar;
  final ZekrCategory category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                MyAppBar(title: category.toString().tr()),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final zekr = azkar[index];
                    return ZekrCard(
                      text: zekr.text,
                      reference: zekr.reference,
                      count: zekr.repeat,
                    );
                  }, childCount: azkar.length),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FinishAzkarButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
