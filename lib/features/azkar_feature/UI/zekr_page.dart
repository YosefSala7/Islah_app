import 'package:app/core/components/appBar.dart';
import 'package:app/features/azkar_feature/UI/finish_azkar.dart';
import 'package:app/features/azkar_feature/UI/zekr_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_azkar/islamic_azkar.dart';

class ZekrPage extends StatelessWidget {
  ZekrPage({super.key, required this.azkar,required this.category});
  List azkar;
  ZekrCategory category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: category.toString().tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: azkar.length,
              itemBuilder: (context, index) {
                final zekr = azkar[index];
                return ZekrCard(
                  text: zekr.text,
                  reference: zekr.reference,
                  count: zekr.repeat,                  
                );
              },
            ),
          ),
          FinishAzkarButton(onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
