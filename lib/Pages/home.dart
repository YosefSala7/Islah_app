import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
import 'package:app/translation/translateClockNumbers.dart';
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
                return Center(child: Row(
                  children: [
                    Container(child: 
                    Text("الفجر:${format12hours(state.apiData.times.fajr).toAr}")),
                    Text("الظهر:${format12hours(state.apiData.times.dhuhr).toAr}"),
                    Text("العصر:${format12hours(state.apiData.times.asr).toAr}"),
                    Text("المغرب:${format12hours(state.apiData.times.maghrib).toAr}"),
                    Text("العشاء:${format12hours(state.apiData.times.isha).toAr}"),
                  ],
                ));
              case PrayerError():
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
      ),
    );
  }
}
