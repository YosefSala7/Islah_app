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
    double cardWidth = MediaQuery.of(context).size.width / 5.6;

    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 7.8,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: prayers.length,
            itemBuilder: (context, index) {
              if (prayers[index]["name"] == state.nextPrayer["name"]) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.outline.withAlpha(255),
                    highlightColor: Theme.of(context).colorScheme.secondary,
                    child: MyCard(
                      15,
                      100,
                      cardWidth,
                      Theme.of(context).colorScheme.outline.withAlpha(70),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(prayers[index]["icon"], size: 20),
                          Text(
                            prayers[index]["name"],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            format12hours(prayers[index]["time"]),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                      MyCard(
                            15,
                            100,
                            cardWidth, 
                            Theme.of(context).cardColor,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(prayers[index]["icon"], size: 20),
                                Text(
                                  prayers[index]["name"],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  format12hours(prayers[index]["time"]).trim(),
                                  style: Theme.of(context).textTheme.bodySmall,
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
