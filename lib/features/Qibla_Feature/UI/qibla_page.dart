import 'package:flutter/material.dart';
import 'package:qibla_compass/qibla_compass.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QiblaScreen(
        theme: QiblaTheme(
          cardBackground: Theme.of(context).cardColor,

          cardBorder: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2D3E5E)
              : const Color(0xFFD6E2F0),

          textPrimary: Theme.of(context).textTheme.bodyLarge!.color!,
          textSecondary: Theme.of(context).textTheme.bodyMedium!.color!,

          backgroundDark: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF0A192F)
              : const Color.fromARGB(255, 185, 195, 207),

          compassFaceEnd: Theme.of(context).colorScheme.primary,
          compassFaceStart: Theme.of(context).colorScheme.secondary,

          accentCyan: Theme.of(context).iconTheme.color!,

          gold: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFC5A021)
              : const Color(0xFF2B6CB0),

          goldLight: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFE6C547)
              : const Color(0xFF63B3ED),
        ),
      ),
    );
  }
}
