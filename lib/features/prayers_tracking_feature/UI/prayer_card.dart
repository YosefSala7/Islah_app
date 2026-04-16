import 'package:app/core/translation/translateClockNumbers.dart';
import 'package:flutter/material.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard({
    super.key,
    required this.prayer,
    required this.prayerTime,
    required this.prayerImg,
    required this.prayerIcon,
    required this.prayerState,
    this.onToggle,
  });

  final String prayer;
  final String prayerTime;
  final String prayerImg;
  final IconData prayerIcon;
  final bool prayerState;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(prayerImg),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            prayerState
                ? Theme.of(context).colorScheme.primary.withAlpha(70)
                : Theme.of(context).colorScheme.secondary.withAlpha(70),
            BlendMode.darken,
          ),
        ),
        border: Border.all(
          width: 1,
          color: prayerState
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(prayerIcon, size: 20),
                ),
                Text(
                  prayer,
                  style: TextStyle(
                    fontWeight: FontWeight(600),
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  format12hours(prayerTime),
                  style: TextStyle(
                    fontWeight: FontWeight(600),
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  hoverColor: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),

                  value: prayerState,
                  onChanged: (bool? value) {
                    DateTime now = DateTime.now();
                    List<String> timeParts = prayerTime.split(':');
                    int prayerHour = int.parse(timeParts[0]);
                    int prayerMinute = int.parse(timeParts[1]);
                    DateTime prayerDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      prayerHour,
                      prayerMinute,
                    );
                    if (now.isAfter(prayerDateTime)) {
                      onToggle?.call();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("لم يحن موعد هذه الصلاة بعد!"),
                        ),
                      );
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
