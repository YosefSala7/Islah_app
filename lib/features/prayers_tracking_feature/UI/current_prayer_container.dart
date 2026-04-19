import 'package:app/core/components/myShimmer.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPrayerContainer extends StatelessWidget {
  const CurrentPrayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/Islamic-background.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.heightOf(context) / 2.7,
          width: MediaQuery.widthOf(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyShimmer(
                hight: 25,
                width: 90,
                isLoading: state.nextPrayer["name"] == null,
                child: Text(
                  state.nextPrayer["name"].toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontFamily: "ReemKufi",
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
              MyShimmer(
                hight: 25,
                width: 105,
                isLoading: state.nextPrayer["time"] == null,
                child: Text(
                  format12hours(state.nextPrayer["time"].toString()),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                    fontFamily: "ReemKufi",
                    fontWeight: FontWeight.normal,
                    fontSize: 35,
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
