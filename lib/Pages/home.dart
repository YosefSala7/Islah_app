import 'dart:ui' as ui;

import 'package:app/Pages/splashScreen.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/current_prayer_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/date_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/last_third_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/UI/prayers_time_widget.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/geoCoding.dart';
import 'package:app/features/prayers_tracking_feature/UI/prayers_tracking_widget.dart';
import 'package:app/features/quran_feature/UI/dialy_random_verse.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                lastThird: state.apiData.times.lastthird,
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
                dayName: state.apiData.date.hijri.weekday.en,
              );
            case PrayerError():
              return HomePage(
                lastThird: state.cachedDate?.data.times.lastthird,
                fajr: state.cachedDate?.data.times.fajr,
                dhuhr: state.cachedDate?.data.times.dhuhr,
                asr: state.cachedDate?.data.times.asr,
                maghrib: state.cachedDate?.data.times.maghrib,
                isha: state.cachedDate?.data.times.isha,
                day: state.cachedDate?.data.date.gregorian.day,
                year: state.cachedDate?.data.date.gregorian.year,
                month: state.cachedDate?.data.date.gregorian.month.en,
                hijriYear: state.cachedDate?.data.date.hijri.year,
                hijriMonth: state.cachedDate?.data.date.hijri.month.en,
                hijriDay: state.cachedDate?.data.date.hijri.day,
                dayName: state.cachedDate?.data.date.hijri.weekday.en,
              );
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String? fajr;
  final String? dhuhr;
  final String? asr;
  final String? maghrib;
  final String? isha;
  final String? hijriYear;
  final String? hijriDay;
  final String? hijriMonth;
  final String? dayName;
  final String? year;
  final String? day;
  final String? month;
  final String? lastThird;

  const HomePage({
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
    required this.day,
    required this.month,
    required this.dayName,
    required this.lastThird,
  });

  List<Map<String, dynamic>> get prayers => [
    {
      "name": "prayer_times.fajr".tr(),
      "time": fajr,
      "icon": WeatherIcons.sunrise,
      "isDoneToday": false,
    },
    {"name": "prayer_times.dhuhr".tr(), "time": dhuhr, "icon": Icons.sunny,"isDoneToday": false,},
    {"name": "prayer_times.asr".tr(), "time": asr, "icon": WeatherIcons.cloudy,"isDoneToday": false,},
    {
      "name": "prayer_times.maghrib".tr(),
      "time": maghrib,
      "icon": WeatherIcons.sunset,
      "isDoneToday": false,
    },
    {
      "name": "prayer_times.isha".tr(),
      "time": isha,
      "icon": Icons.nights_stay_sharp,
      "isDoneToday": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimeCubit(prayers),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                pinned: true,
                expandedHeight: MediaQuery.heightOf(context) / 10,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Assalamu_Alaikum".tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            FutureBuilder(
                              future: getGeolocationFromCache(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return const SizedBox();
                                final data = snapshot.data!;
                                List address = [
                                  data["cityName"],
                                  data["subCity"],
                                  data["governorate"],
                                ]
                                    .where((e) => e != null && e.isNotEmpty)
                                    .toList();

                                String formattedAddress = address.join(", ");
                                String shortAddress = formattedAddress.length > 12
                                    ? formattedAddress.substring(0, 17)
                                    : formattedAddress;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: ui.TextDirection.ltr,
                                  children: [
                                    Icon(Icons.location_on, size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                      shortAddress,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  expandedTitleScale: 1.2,
                ),
              ),

              SliverToBoxAdapter(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CurrentPrayerWidget(),
                        PrayersTime(prayers: prayers),
                        DateWidget(
                          dayName: dayName,
                          hijriDay: hijriDay,
                          hijriMonth: hijriMonth,
                          hijriYear: hijriYear,
                          year: year,
                          month: month,
                          day: day,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LastThirdWidget(time: lastThird!),
                            PrayersTrackingWidget(prayers: prayers),
                          ],
                        ),
                        DialyRandomVerse(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
