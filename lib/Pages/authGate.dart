import 'dart:io';
import 'package:app/Pages/navBar.dart';
import 'package:app/ads/app_apening_ad.dart';
import 'package:app/features/notifcations_feature/noti_service.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiCubit.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerApiState.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/fetchPrayerTimesAPI.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/geoCoding.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/getLocation.dart';
import 'package:app/Pages/splashScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late Future<String> _targetScreenFuture;

  @override
  void initState() {
    super.initState();
    _targetScreenFuture = _determineTargetScreen();
    getGeoLocation();
    AppOpenAdService().loadAd();
  }

  Future<bool> _showErrorDialog({
    required String title,
    required String message,
    required String retryLabel,
    required String exitLabel,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(title.tr()),
            content: Text(message.tr()),
            actions: [
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  exitLabel.tr(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(retryLabel.tr()),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<String> _determineTargetScreen() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('cached_body') != null) return 'go_to_home';

    bool isSuccess = false;

    while (!isSuccess) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      bool isConnected = connectivityResult.any(
        (res) => res != ConnectivityResult.none,
      );

      if (!isConnected) {
        await _showErrorDialog(
          title: "wifi_error_welcome",
          message: "wifi_error_message",
          retryLabel: "wifi_error_button_text",
          exitLabel: "exit_app",
        );
        continue;
      }

      try {
        await determinePosition();

        await getPrayerTimes();

        isSuccess = true;
      } catch (e) {
        await _showErrorDialog(
          title: "location_error_title",
          message: "location_error_content",
          retryLabel: "try_again",
          exitLabel: "exit_app",
        );
      }
    }

    return 'go_to_home';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _targetScreenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splashscreen();
        }

        return BlocProvider<PrayerApiCubit>(
          create: (context) => PrayerApiCubit()..getData(),
          child: BlocBuilder<PrayerApiCubit, PrayerApiState>(
            builder: (context, state) {
              if(state is PrayerLoading){
                return AnotherSplashScreen();
              }else{
                return Navbar();
              }
            },
          ),
        );
      },
    );
  }
}
