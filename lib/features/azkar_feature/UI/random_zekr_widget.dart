import 'package:app/core/components/card.dart';
import 'package:flutter/material.dart';
import 'package:islamic_azkar/islamic_azkar.dart';

class QuickZekr extends StatefulWidget {
  const QuickZekr({super.key});

  @override
  State<QuickZekr> createState() => _QuickZekrState();
}

class _QuickZekrState extends State<QuickZekr> {
  String zekr = IslamicAzkarService().getRandomZekr()!.text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () {
          String newZekr = IslamicAzkarService().getRandomZekr()!.text;
          while(newZekr.length>110){
            newZekr = IslamicAzkarService().getRandomZekr()!.text;
          }
          setState(() {
            zekr=newZekr;
          });
        },
        child: MyCard(
          25,
          MediaQuery.heightOf(context) / 4,
          MediaQuery.widthOf(context),
          Theme.of(context).cardColor,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(120),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "ذكر سريع",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.rocket_launch,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color!,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.heightOf(context) / 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        zekr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.fontSize!,
                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(120),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              " اضغط لتغيير الذكر",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.touch_app_rounded,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color!,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
