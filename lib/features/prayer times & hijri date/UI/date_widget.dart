import 'package:app/core/components/card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class DateWidget extends StatelessWidget {
  DateWidget({
    super.key,
    required this.hijriYear,
    required this.hijriMonth,
    required this.hijriDay,
    required this.year,
    required this.month,
    required this.day,
    required this.dayName,
  });
  String? hijriYear;
  String? hijriDay;
  String? hijriMonth;
  String? dayName;
  String? year;
  String? day;
  String? month;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: MyCard(
        25,
        MediaQuery.heightOf(context)/4.2,
        double.infinity,
        Theme.of(context).cardColor,
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                dayName!.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Divider(
                color: Theme.of(context).colorScheme.outline,
                height: 20,
                thickness: 1,
                indent: MediaQuery.widthOf(context) / 3,
                endIndent: MediaQuery.widthOf(context) / 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withAlpha(100),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Theme.of(context).colorScheme.secondary
                                .withBlue(230)
                                .withGreen(150),
                            size: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Gregorian".tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${year!} ${month!.tr()} ${day!}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withAlpha(100),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            FlutterIslamicIcons.solidAllah,
                            color: Theme.of(context).colorScheme.secondary
                                .withBlue(230)
                                .withGreen(150),
                            size: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Hijri".tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${hijriYear!} ${hijriMonth!.tr()} ${hijriDay!}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
