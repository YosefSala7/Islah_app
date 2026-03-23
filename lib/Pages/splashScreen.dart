import 'package:flutter/material.dart';

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
              Color.fromARGB(255, 0, 0, 66),
              Color.fromARGB(255, 129, 213, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 0),
            Image.asset("assets/imgs/appIcon.png", width: 300),
            const CircularProgressIndicator(color: Colors.white),
            const Text('V 1.0.0', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}