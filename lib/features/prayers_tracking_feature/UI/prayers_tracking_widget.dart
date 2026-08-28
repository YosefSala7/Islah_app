import 'package:app/core/components/card.dart';
import 'package:app/features/prayers_tracking_feature/UI/prayers_trackng_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrayersTrackingWidget extends StatelessWidget {
  const PrayersTrackingWidget({super.key, required this.prayers});
  final List<Map<String, dynamic>> prayers;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => PrayersTrackngPage(prayers: prayers),
          ),
        );
      },
      child:
          MyCard(
                20,
                MediaQuery.heightOf(context) / 7,
                MediaQuery.widthOf(context) / 2.3,
                Theme.of(context).cardColor,
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.heightOf(context) / 11,
                          child: Image.asset("assets/imgs/pray.webp"),
                        ),
                        Text(
                          "prayers_tracking".tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: MediaQuery.heightOf(context) / 50,
                              ),
                        ),
                      ],
                    ),
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
