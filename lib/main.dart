import 'package:app/Global%20State%20Managment/darkModeCubit.dart';
import 'package:app/Global%20State%20Managment/darkModeState.dart';
import 'package:app/Pages/authGate.dart';
import 'package:app/colorsManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  bool savedDark = prefs.getBool("isDarkMode") ?? false;
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: 'lib/translation',
      fallbackLocale: const Locale('ar'),
      child: BlocProvider<DarkCubit>(
        create: (context) => DarkCubit(savedDark),
        child:  MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkCubit, DarkModeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode:  state.isDark? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          home: AuthGate(),
        );
      },
    );
  }
}
