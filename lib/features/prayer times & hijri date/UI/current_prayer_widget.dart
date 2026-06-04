import 'package:app/core/components/card.dart';
import 'package:app/core/components/myShimmer.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CurrentPrayerWidget extends StatelessWidget {
  const CurrentPrayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child:
              MyCard(
                    25,
                    MediaQuery.heightOf(context) / 4,
                    double.infinity,
                    Theme.of(context).cardColor,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                              "next_prayer".tr(),
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                            .animate()
                            .fadeIn(duration: 600.ms, begin: -2.0)
                            .scale(
                              duration: 600.ms,
                              begin: Offset(-2, -2),
                              curve: Curves.elasticOut,
                            ),

                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child:
                              MyShimmer(
                                    hight: 25,
                                    width: 90,
                                    isLoading: state.nextPrayer["name"] == null,
                                    child: Shimmer.fromColors(
                                      loop: 8,
                                      direction: ShimmerDirection.rtl,
                                      baseColor: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.color!,
                                      highlightColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      child: Text(
                                        state.nextPrayer["name"].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontFamily: "ReemKufi",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 40,
                                            ),
                                      ),
                                    ),
                                  )
                                  .animate(delay: 200.ms)
                                  .fadeIn(duration: 700.ms, begin: -2.0)
                                  .scale(
                                    duration: 700.ms,
                                    begin: Offset(-2, -2),
                                    curve: Curves.bounceOut,
                                  ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child:
                              MyShimmer(
                                    hight: 25,
                                    width: 105,
                                    isLoading: state.nextPrayer["time"] == null,
                                    child: Shimmer.fromColors(
                                      loop: 8,
                                      baseColor: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.color!,
                                      highlightColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      child: Text(
                                        "${"in".tr()} ${format12hours(state.nextPrayer["time"].toString())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontFamily: "ReemKufi",
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  )
                                  .animate(delay: 400.ms)
                                  .fadeIn(duration: 700.ms, begin: -2.0)
                                  .scale(
                                    duration: 700.ms,
                                    begin: Offset(-2, -2),
                                  ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:
                              MyCard(
                                    50,
                                    MediaQuery.heightOf(context) / 24,
                                    MediaQuery.widthOf(context) / 1.65,
                                    Theme.of(context).cardColor,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.hourglass_top_rounded,
                                          color: Theme.of(
                                            context,
                                          ).iconTheme.color,
                                          size: 20,
                                        ),
                                        Text(
                                          "${"remaining_time".tr()}: ",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        MyShimmer(
                                          hight: 15,
                                          isLoading:
                                              state.nextPrayer["remaining"] ==
                                              null,
                                          width: 40,
                                          child: Text(
                                            state.nextPrayer["remaining"]
                                                .toString(),
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .animate(delay: 600.ms)
                                  .fadeIn(duration: 800.ms, begin: -2.0)
                                  .scale(
                                    duration: 800.ms,
                                    begin: Offset(-2, -2),
                                    curve: Curves.elasticOut,
                                  ),
                        ),
                      ],
                    ),
                  )
                  .animate(delay: 50.ms)
                  .slideY(
                    begin: 0.7,
                    end: 0,
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(duration: Duration(milliseconds: 800)),
        );
      },
    );
  }
}
