import 'package:app/Pages/splashScreen.dart';
import 'package:app/core/components/card.dart';
import 'package:app/core/components/myShimmer.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/current_prayer_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/prayers_time_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/geoCoding.dart';
import 'package:app/core/translation/translateClockNumbers.dart';
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
    {
      "name": "prayer_times.fajr".tr(),
      "time": fajr,
      "icon": WeatherIcons.sunrise,
    },
    {
      "name": "prayer_times.dhuhr".tr(),
      "time": dhuhr,
      "icon": Icons.sunny,
    },
    {
      "name": "prayer_times.asr".tr(),
      "time": asr,
      "icon": WeatherIcons.cloudy,
    },
    {
      "name": "prayer_times.maghrib".tr(),
      "time": maghrib,
      "icon": WeatherIcons.sunset,
    },
    {
      "name": "prayer_times.isha".tr(),
      "time": isha,
      "icon": Icons.nights_stay_sharp,
    },
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: getGeolocationFromCache(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Text("الموقع غير محدد");
                        }

                        final data = snapshot.data!;
                        final List address = [];
                        if (data["cityName"]!.isNotEmpty) {
                          address.add(data["cityName"]!.toString());
                        }
                        if (data["subCity"]!.isNotEmpty) {
                          address.add(data["subCity"]!.toString());
                        }
                        if (data["governorate"]!.isNotEmpty) {
                          address.add(data["governorate"]!.toString());
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                address.join(","),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    CurrentPrayerWidget(),
                    PrayersTime(prayers: prayers),
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
