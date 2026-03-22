import 'package:app/Pages/home.dart';
import 'package:app/repos/fetchPrayerTimesAPI.dart';
import 'package:app/repos/getLocation.dart';
import 'package:app/splashScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart' as wifi_error_message;
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
    determinePosition();
  }

  void _retry() {
    setState(() {
      _targetScreenFuture = _determineTargetScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _targetScreenFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Splashscreen();
        }

        if (snapshot.data == 'show_connection_error') {
          return _buildNoInternetUI();
        }

        return const Home();
      },
    );
  }

  Future<String> _determineTargetScreen() async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cached_body');

    if (cachedData != null) return 'go_to_home';

    var connectivityResult = await (Connectivity().checkConnectivity());

    bool isConnected =
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet);

    if (isConnected) {
      try {
        await getPrayerTimes();
        return 'go_to_home';
      } catch (e) {
        return 'show_connection_error';
      }
    } else {
      return 'show_connection_error';
    }
  }

  Widget _buildNoInternetUI() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                "wifi_error_welcome".tr(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "wifi_error_message".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: Text("wifi_error_button_text".tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
