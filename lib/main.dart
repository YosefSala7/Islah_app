import 'package:app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('ar');
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Cairo'),
    locale: const Locale('ar', 'EG'), 
  supportedLocales: [
    Locale('ar', 'EG'),
  ],
  
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
    home: Splashscreen(),));
}