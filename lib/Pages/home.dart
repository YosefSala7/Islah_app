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
    return BlocProvider<PrayerApiCubit>(
      create: (context) => PrayerApiCubit()..getData(),
      child: Scaffold(
        body: BlocBuilder<PrayerApiCubit, PrayerApiState>(
          builder: (context, state) {
            switch (state) {
              case PrayerLoading():
                return Center(child: CircularProgressIndicator());
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
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
      ),
    );
  }
}
