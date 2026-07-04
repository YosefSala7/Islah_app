import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/core/Global%20State%20Managment/darkModeCubit.dart';
import 'package:app/core/Global%20State%20Managment/darkModeState.dart';
import 'package:app/Pages/authGate.dart';
import 'package:app/core/colorsManager.dart';
import 'package:app/core/scheduel_Daily_Tasks.dart';
import 'package:app/features/notifcations_feature/noti_service.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsir_library/tafsir_library.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotiService().init();
  await scheduelDailyTasks();
  await MobileAds.instance.initialize();
  List<String> testDeviceIds = ["58297F7BAC308FD48AE4784C0B50084E"];
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: testDeviceIds,
  );
  MobileAds.instance.updateRequestConfiguration(configuration);

  await LocalNotiService().init();

  await EasyLocalization.ensureInitialized();
  await TafsirLibrary.initialize();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  bool savedDark = prefs.getBool("isDarkMode") ?? false;
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: 'lib/core/translation',
      fallbackLocale: const Locale('ar'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DarkCubit>(create: (context) => DarkCubit(savedDark)),
          BlocProvider<SavePageCubit>(create: (context) => SavePageCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void _updateColor(bool isDark) async {
    await FlutterStatusbarcolor.setStatusBarColor(
      isDark ? Color(0xFF0A192F) : Color(0xFFF0F4F8),
    );
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(isDark);
    await FlutterStatusbarcolor.setNavigationBarColor(
      isDark ? Color(0xFF112240) : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkCubit, DarkModeState>(
      builder: (context, state) {
        _updateColor(state.isDark);
        return ThemeProvider(
          duration: Duration(milliseconds: 800),
          initTheme: state.isDark ? ThemeData.dark() : ThemeData.light(),
          builder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: AuthGate(),
            );
          },
        );
      },
    );
  }
}
