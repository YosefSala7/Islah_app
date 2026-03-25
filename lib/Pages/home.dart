import 'package:app/Pages/splashScreen.dart';
import 'package:app/components/card.dart';
import 'package:app/components/myShimmer.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerTimeState.dart';
import 'package:app/translation/translateClockNumbers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PrayerApiCubit>(),
      child: BlocBuilder<PrayerApiCubit, PrayerApiState>(
        builder: (context, state) {
          switch (state) {
            case PrayerLoading():
              return AnotherSplashScreen();
            case PrayerLoaded():
              return HomePage(
                fajr: state.apiData.times.fajr,
                dhuhr: state.apiData.times.dhuhr,
                asr: state.apiData.times.asr,
                maghrib: state.apiData.times.maghrib,
                isha: state.apiData.times.isha,
                day: state.apiData.date.gregorian.day,
                year: state.apiData.date.gregorian.year,
                month: state.apiData.date.gregorian.month.en,
                hijriYear: state.apiData.date.hijri.year,
                hijriMonth: state.apiData.date.hijri.month.en,
                hijriDay: state.apiData.date.hijri.day,
              );
            case PrayerError():
              return HomePage(
                fajr: state.cachedDate?.times.fajr,
                dhuhr: state.cachedDate?.times.dhuhr,
                asr: state.cachedDate?.times.asr,
                maghrib: state.cachedDate?.times.maghrib,
                isha: state.cachedDate?.times.isha,
                day: state.cachedDate?.data.date.gregorian.day,
                year: state.cachedDate?.data.date.gregorian.year,
                month: state.cachedDate?.data.date.gregorian.month.en,
                hijriYear: state.cachedDate?.data.date.hijri.year,
                hijriMonth: state.cachedDate?.data.date.hijri.month.en,
                hijriDay: state.cachedDate?.data.date.hijri.day,
              );
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.hijriYear,
    required this.hijriMonth,
    required this.hijriDay,
    required this.year,
    required this.month,
    required this.day,
  });
  String fajr;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;
  List<Map> get prayers => [
    {"name": "prayer_times.fajr".tr(), "time": fajr,"icon": Icon(WeatherIcons.sunrise)},
    {"name": "prayer_times.dhuhr".tr(), "time": dhuhr,"icon": Icon(WeatherIcons.day_sunny)},
    {"name": "prayer_times.asr".tr(), "time": asr,"icon": Icon(WeatherIcons.cloud_down)},
    {"name": "prayer_times.maghrib".tr(), "time": maghrib,"icon": Icon(WeatherIcons.sunset)},
    {"name": "prayer_times.isha".tr(), "time": isha,"icon": Icon(WeatherIcons.moon_alt_full)},
  ];
  String? hijriYear;
  String? hijriDay;
  String? hijriMonth;
  String? year;
  String? day;
  String? month;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimeCubit(prayers),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
                      builder: (context, state) {
                        return MyCard(
                          20,
                          150,
                          double.infinity,
                          Theme.of(context).cardColor,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("next_prayer".tr()),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: MyShimmer(
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
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
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
                                    baseColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    highlightColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    child: Text(
                                      "${"in".tr()} ${format12hours(state.nextPrayer["time"].toString())}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
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
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      MyShimmer(
                                        hight: 15,
                                        isLoading:
                                            state.nextPrayer["remaining"] == null,
                                        width: 40,
                                        child: Text(
                                          state.nextPrayer["remaining"] ??
                                              "Loading...".tr().toString(),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
