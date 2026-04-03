import 'package:app/core/components/card.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LastThirdWidget extends StatelessWidget {
  LastThirdWidget({super.key, required this.time});
  String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                height: MediaQuery.heightOf(context) / 3.5,
                width: MediaQuery.widthOf(context) / 1.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Text(
                        "ثلث الليل الآخر وقت فاضل من الأوقات التي تظن فيها استجابة الدعاء، فهو وقت التنزل لقول النبي صلى الله عليه وسلم: (ينزل ربنا تبارك وتعالى كل ليلة إلى السماء الدنيا حين يبقى ثلث الليل الآخر يقول: 'من يدعوني فأستجيب له، من يسألني فأعطيه، من يستغفرني فأغفر له' ). متفق عليه",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child:
          MyCard(
                20,
                MediaQuery.heightOf(context) / 7,
                MediaQuery.widthOf(context) / 2.2,
                Theme.of(context).cardColor,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "last_third".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              format12hours(time),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.info_outline_rounded,
                        size: MediaQuery.widthOf(context) / 24,
                      ),
                    ],
                  ),
                ),
              )
              .animate(delay: 200.ms)
              .slideY(
                begin: 0.7,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: Duration(milliseconds: 800)),
    );
  }
}
