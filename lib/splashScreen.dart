import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 0),
          Image.asset("assets/imgs/appIcon.png", width: 300),
          Text('V 1.0.0'),
        ],
      ),
      nextScreen: MainApp(),
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 0, 0, 66),
          Color.fromARGB(255, 129, 213, 255),
        ],
      ),
    );
  }
}