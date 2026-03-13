import 'package:app/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Splashscreen(),));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      );
    
  }
}
