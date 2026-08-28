import 'package:app/core/components/card.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PrayersTime extends StatelessWidget {
  PrayersTime({super.key, required this.prayers});
  List<Map> prayers;

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 6;
    double cardHight = MediaQuery.of(context).size.height / 7;

    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: prayers.length,
            itemBuilder: (context, index) {
              if (prayers[index]["name"] == state.nextPrayer["name"]) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      MyCard(
                        15,
                        cardHight,
                        cardWidth,
                        Theme.of(context).scaffoldBackgroundColor,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              prayers[index]["icon"],
                              height: cardWidth / 1.35,
                            ),
                            Text(
                              prayers[index]["name"],
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: cardWidth / 4.2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                            Text(
                              format12hours(prayers[index]["time"]),
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: cardWidth / 4.4,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Shimmer(
                        enabled: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Theme.brightnessOf(context) == Brightness.dark
                                ? Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .selectedItemColor!
                                      .withAlpha(20)
                                : Theme.of(
                                    context,
                                  ).colorScheme.secondary.withAlpha(20),
                            Theme.brightnessOf(context) == Brightness.dark
                                ? Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .selectedItemColor!
                                      .withAlpha(150)
                                : Theme.of(
                                    context,
                                  ).colorScheme.secondary.withAlpha(150),
                            Theme.brightnessOf(context) == Brightness.dark
                                ? Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .selectedItemColor!
                                      .withAlpha(20)
                                : Theme.of(
                                    context,
                                  ).colorScheme.secondary.withAlpha(20),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                        ),
                        child: Container(
                          height: cardHight,
                          width: cardWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withAlpha(255),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child:
                      MyCard(
                            15,
                            cardHight,
                            cardWidth,
                            Theme.of(context).cardColor,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  prayers[index]["icon"],
                                  height: cardWidth / 1.35,
                                ),
                                Text(
                                  prayers[index]["name"],
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(fontSize: cardWidth / 4.2),
                                ),
                                Text(
                                  format12hours(prayers[index]["time"]).trim(),
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(fontSize: cardWidth / 4.4),
                                ),
                              ],
                            ),
                          )
                          .animate(delay: 100.ms)
                          .slideY(
                            begin: 0.7,
                            end: 0,
                            duration: 800.ms,
                            curve: Curves.easeOutBack,
                          )
                          .fadeIn(duration: Duration(milliseconds: 800)),
                );
              }
            },
          ),
        );
      },
    );
  }
}
