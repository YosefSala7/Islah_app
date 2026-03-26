import 'package:app/core/components/card.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PrayersTime extends StatelessWidget {
  PrayersTime({super.key,required this.prayers});
  List <Map> prayers;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return SizedBox(
                          height: 85,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: prayers.length,
                            itemBuilder: (context, index) {
                              if (prayers[index]["name"] ==
                                  state.nextPrayer["name"]) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Shimmer.fromColors(
                                    child: MyCard(
                                      10,
                                      80,
                                      64,
                                      Theme.of(
                                        context,
                                      ).colorScheme.outline.withAlpha(70),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(prayers[index]["icon"]),
                                          Text(prayers[index]["name"]),
                                          Text(
                                            format12hours(
                                              prayers[index]["time"],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    baseColor: Theme.of(
                                      context,
                                    ).colorScheme.outline.withAlpha(255),
                                    highlightColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: MyCard(
                                    10,
                                    80,
                                    64,
                                    Theme.of(context).cardColor,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(prayers[index]["icon"]),
                                        Text(prayers[index]["name"]),
                                        Text(
                                          format12hours(
                                            prayers[index]["time"],
                                          ).trim(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
      },
    );
  }
}