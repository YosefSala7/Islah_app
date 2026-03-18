import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerApiState.dart';
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
                    Container(child: Text("الفجر:${state.apiData.times.fajr.toString()}")),
                    Text("الظهر:${state.apiData.times.dhuhr}"),
                    Text("العصر:${state.apiData.times.asr}"),
                    Text("المغرب:${state.apiData.times.maghrib}"),
                    Text("العشاء:${state.apiData.times.isha}"),
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
