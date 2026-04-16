import 'package:app/features/azkar_feature/UI/finish_azkar.dart';
import 'package:app/features/azkar_feature/UI/zekr_card.dart';
import 'package:flutter/material.dart';

class ZekrPage extends StatelessWidget {
  ZekrPage({super.key, required this.azkar});
  List azkar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
