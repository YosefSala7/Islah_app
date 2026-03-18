import 'package:app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
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