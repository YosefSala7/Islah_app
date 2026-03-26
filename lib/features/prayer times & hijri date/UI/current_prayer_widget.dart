import 'package:app/core/components/card.dart';
import 'package:app/core/components/myShimmer.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
          child: MyCard(
            20,
            165,
            double.infinity,
            Theme.of(context).cardColor,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "next_prayer".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyShimmer(
                    hight: 25,
                    width: 90,
                    isLoading: state.nextPrayer["name"] == null,
                    child: Shimmer.fromColors(
                      loop: 8,
                      direction: ShimmerDirection.rtl,
                      baseColor: Theme.of(context).textTheme.bodyLarge!.color!,
                      highlightColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        state.nextPrayer["name"].toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyShimmer(
                    hight: 25,
                    width: 105,
                    isLoading: state.nextPrayer["time"] == null,
                    child: Shimmer.fromColors(
                      loop: 8,
                      baseColor: Theme.of(context).textTheme.bodyLarge!.color!,
                      highlightColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        "${"in".tr()} ${format12hours(state.nextPrayer["time"].toString())}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MyCard(
                    50,
                    30,
                    190,
                    Theme.of(context).cardColor,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_bottom_rounded,
                          color: Theme.of(context).iconTheme.color,
                          size: 20,
                        ),
                        Text(
                          "${"remaining_time".tr()}: ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        MyShimmer(
                          hight: 15,
                          isLoading: state.nextPrayer["remaining"] == null,
                          width: 40,
                          child: Text(
                            state.nextPrayer["remaining"].toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
