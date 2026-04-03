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
                isha: state.cachedDate?.data.times.fajr,
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
    required this.dayName,
    required this.lastThird,
  });
  String? fajr;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;
  String? hijriYear;
  String? hijriDay;
  String? hijriMonth;
  String? dayName;
  String? year;
  String? day;
  String? month;
  String? lastThird;
  List<Map> get prayers => [
    {
      "name": "prayer_times.fajr".tr(),
      "time": fajr,
      "icon": WeatherIcons.sunrise,
    },
    {"name": "prayer_times.dhuhr".tr(), "time": dhuhr, "icon": Icons.sunny},
    {"name": "prayer_times.asr".tr(), "time": asr, "icon": WeatherIcons.cloudy},
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
                                List address =
                                    [
                                          data["cityName"],
                                          data["subCity"],
                                          data["governorate"],
                                        ]
                                        .where((e) => e != null && e.isNotEmpty)
                                        .toList();

                                String formattedAddress = address.join(", ");
                                String shortAddress =
                                    formattedAddress.length > 12
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
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
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
                        LastThirdWidget(time: lastThird!),
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
