import 'package:app/core/components/card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class DateWidget extends StatelessWidget {
  final String? hijriYear;
  final String? hijriDay;
  final String? hijriMonth;
  final String? dayName;
  final String? year;
  final String? day;
  final String? month;

  const DateWidget({
    super.key,
    required this.hijriYear,
    required this.hijriMonth,
    required this.hijriDay,
    required this.year,
    required this.month,
    required this.day,
    required this.dayName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child:
          MyCard(
                25,
                MediaQuery.heightOf(context) / 4.2,
                double.infinity,
                Theme.of(context).cardColor,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                            dayName!.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                          .animate(delay: 200.ms)
                          .slideX(
                            begin: 1,
                            end: 0,
                            duration: 200.ms,
                            curve: Curves.easeIn,
                          )
                          .fadeIn(),
                      Divider(
                        color: Theme.of(context).colorScheme.outline,
                        height: 10,
                        thickness: 1,
                        indent: MediaQuery.widthOf(context) / 3,
                        endIndent: MediaQuery.widthOf(context) / 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                    "assets/imgs/calander.webp",
                                    height: 60,
                                  )
                                  .animate(delay: 200.ms)
                                  .fadeIn(duration: 600.ms, begin: -2.0)
                                  .scale(
                                    duration: 600.ms,
                                    begin: Offset(-2, -2),
                                    curve: Curves.elasticOut,
                                  ),
                              Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "Gregorian".tr(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  )
                                  .animate(delay: 200.ms)
                                  .fade()
                                  .slideY(
                                    begin: 0.7,
                                    end: 0,
                                    duration: 800.ms,
                                    curve: Curves.easeOutBack,
                                  )
                                  .fadeIn(
                                    duration: Duration(milliseconds: 800),
                                  ),
                              Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "${year!} ${month!.tr()} ${day!}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  )
                                  .animate(delay: 200.ms)
                                  .fade()
                                  .slideY(
                                    begin: 0.7,
                                    end: 0,
                                    duration: 800.ms,
                                    curve: Curves.easeOutBack,
                                  )
                                  .fadeIn(
                                    duration: Duration(milliseconds: 800),
                                  ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.heightOf(context) / 9,
                            child: VerticalDivider(
                              thickness: 1,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/imgs/Allah.webp",
                                height: 60,
                              )
                                  .animate(delay: 200.ms)
                                  .fadeIn(duration: 600.ms, begin: -2.0)
                                  .scale(
                                    duration: 600.ms,
                                    begin: Offset(-2, -2),
                                    curve: Curves.elasticOut,
                                  ),
                              Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "Hijri".tr(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  )
                                  .animate(delay: 200.ms)
                                  .fade()
                                  .slideY(
                                    begin: 0.7,
                                    end: 0,
                                    duration: 1000.ms,
                                    curve: Curves.easeOutBack,
                                  )
                                  .fadeIn(
                                    duration: Duration(milliseconds: 800),
                                  ),
                              Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "${hijriYear!} ${hijriMonth!.tr()} ${hijriDay!}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  )
                                  .animate(delay: 200.ms)
                                  .fade()
                                  .slideY(
                                    begin: 0.7,
                                    end: 0,
                                    duration: 800.ms,
                                    curve: Curves.easeOutBack,
                                  )
                                  .fadeIn(
                                    duration: Duration(milliseconds: 800),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .animate(delay: 150.ms)
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
