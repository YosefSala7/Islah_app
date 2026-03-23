import 'package:app/Pages/splashScreen.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
import 'package:app/translation/translateClockNumbers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PrayerApiCubit>(),
      child: Scaffold(
        body: BlocBuilder<PrayerApiCubit, PrayerApiState>(
          builder: (context, state) {
            switch (state) {
              case PrayerLoading():
                return AnotherSplashScreen();
              case PrayerLoaded():
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "${"prayer_times.fajr".tr()}:${format12hours(state.apiData.times.fajr)}",
                      ),
                      Text(
                        "${"prayer_times.dhuhr".tr()}:${format12hours(state.apiData.times.dhuhr)}",
                      ),
                      Text(
                        "${"prayer_times.asr".tr()}:${format12hours(state.apiData.times.asr)}",
                      ),
                      Text(
                        "${"prayer_times.maghrib".tr()}:${format12hours(state.apiData.times.maghrib)}",
                      ),
                      Text(
                        "${"prayer_times.isha".tr()}:${format12hours(state.apiData.times.isha)}",
                      ),
                    ],
                  ),
                );
              case PrayerError():
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "${"prayer_times.fajr".tr()}:${format12hours(state.cachedDate?.times.fajr)}",
                      ),
                      Text(
                        "${"prayer_times.dhuhr".tr()}:${format12hours(state.cachedDate?.times.dhuhr)}",
                      ),
                      Text(
                        "${"prayer_times.asr".tr()}:${format12hours(state.cachedDate?.times.asr)}",
                      ),
                      Text(
                        "${"prayer_times.maghrib".tr()}:${format12hours(state.cachedDate?.times.maghrib)}",
                      ),
                      Text(
                        "${"prayer_times.isha".tr()}:${format12hours(state.cachedDate?.times.isha)}",
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}