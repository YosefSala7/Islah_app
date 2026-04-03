import 'package:app/core/components/myShimmer.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CurrentPrayerContainer extends StatelessWidget {
  const CurrentPrayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          height: MediaQuery.heightOf(context) / 3.3,
          width: MediaQuery.widthOf(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyShimmer(
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
              MyShimmer(
                hight: 25,
                width: 105,
                isLoading: state.nextPrayer["time"] == null,
                child: Shimmer.fromColors(
                  loop: 8,
                  baseColor: Theme.of(context).textTheme.bodyLarge!.color!,
                  highlightColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    format12hours(state.nextPrayer["time"].toString()),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
