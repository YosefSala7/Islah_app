import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 27, 58, 87),
              Color.fromARGB(255, 15, 34, 51),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 0),
            Image.asset("assets/imgs/splashScreen_logo.png", width: 300),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 50),
            const Text('V 1.0.0', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class AnotherSplashScreen extends StatelessWidget {
  const AnotherSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      onInit: () => debugPrint("On Init"),
      onEnd: () => debugPrint("On End"),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      childWidget: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 1.2,
            colors: [Color.fromARGB(255, 47, 113, 117), Color(0xFF0F1E2A)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -110,
              left: MediaQuery.widthOf(context) / 5,
              child: Image.asset(
                "assets/imgs/pattern.webp",
                color: Colors.white24,
                width: 220,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 0),
                Image.asset("assets/imgs/splashScreen_logo.png", width: 200),
                const CircularProgressIndicator(color: Colors.white),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "يحتوي هذا التطبيق على إعلانات بسيطة لدعم استمرار العمل عليه والتفرغ لتطويره.. جزاكم الله خيراً",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('V 1.0.0', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
      animationDuration: const Duration(milliseconds: 1500),
      asyncNavigationCallback: () async {
        return;
      },
    );
  }
}
