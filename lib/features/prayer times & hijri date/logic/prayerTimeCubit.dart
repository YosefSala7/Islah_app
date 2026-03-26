import 'dart:async';
import 'package:app/features/prayer%20times%20&%20hijri%20date/logic/prayerTimeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  final List<Map> allPrayers; 
  Timer? _timer;

  PrayerTimeCubit(this.allPrayers) : super(PrayerTimeInit()) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      Map next = _findNextPrayer(now);

      String remaining = _calculateRemaining(next['time']);

      emit(
        PrayerTimeUpdate(DateFormat('hh:mm:ss a').format(now), {
          'name': next['name'],
          'time': next['time'],
          'remaining': remaining,
        }),
      );
    });
  }

Map _findNextPrayer(DateTime now) {
  for (var prayer in allPrayers) {
    final prayerTime = _parseTimeToday(prayer['time']);
    
    if (prayerTime.isAfter(now)) {
      return prayer;
    }
  }
  
  return allPrayers[0]; 
}

DateTime _parseTimeToday(String? timeStr) {
  if (timeStr == null || !timeStr.contains(':')) return DateTime.now();

  try {
    final parts = timeStr.split(':');
    final now = DateTime.now();
    int hour = int.tryParse(parts[0].trim()) ?? 0;
    int minute = int.tryParse(parts[1].trim()) ?? 0;
    return DateTime(now.year, now.month, now.day, hour, minute);
  } catch (e) {
    return DateTime.now();
  }
}

String _calculateRemaining(String? targetTime) {
  if (targetTime == null || targetTime.isEmpty || !targetTime.contains(':')) {
    return "--:--:--"; 
  }

  try {
    final targetDateTime = _parseTimeToday(targetTime);
    final diff = targetDateTime.difference(DateTime.now());

    if (diff.isNegative) {
      return "00:00:00"; 
    }

    String h = diff.inHours.toString().padLeft(2, '0');
    String m = (diff.inMinutes % 60).toString().padLeft(2, '0');
    String s = (diff.inSeconds % 60).toString().padLeft(2, '0');

    return "$h:$m:$s";
    
  } catch (e) {
    return "--:--:--";
  }
}

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
