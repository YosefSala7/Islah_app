import 'dart:async';
import 'package:app/features/prayer%20times%20&%20hijri%20date/prayer%20API%20State%20management/prayerTimeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  final List<Map> allPrayers; // [{name: 'Fajr', time: '05:10'}, ...]
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
      if (_parseTime(prayer['time']).isAfter(now)) return prayer;
    }
    return allPrayers[0]; 
  }

DateTime _parseTime(String? timeStr) {
    // 1. فحص الأمان: لو مفيش وقت أو الوقت مش واخد تنسيق صح
    if (timeStr == null || !timeStr.contains(':')) {
      return DateTime.now(); // بيرجع وقت حالي كـ backup
    }

    try {
      final parts = timeStr.split(':');
      final now = DateTime.now();
      int hour = int.tryParse(parts[0].trim()) ?? 0;
      int minute = int.tryParse(parts[1].trim()) ?? 0;

      var date = DateTime(now.year, now.month, now.day, hour, minute);
      
      if (date.isBefore(now)) {
        date = date.add(const Duration(days: 1));
      }
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

String _calculateRemaining(String? targetTime) {
  // 1. لو الوقت اللي داخل نال أو مش واخد تنسيق الساعة الصح، ابعت الشرطات فوراً
  if (targetTime == null || targetTime.isEmpty || !targetTime.contains(':')) {
    return "--:--:--"; 
  }

  try {
    // 2. بنحسب الفرق بين الوقت المستهدف والوقت الحالي
    final targetDateTime = _parseTime(targetTime);
    final diff = targetDateTime.difference(DateTime.now());

    // 3. لو الوقت خلص (بقى بالسالب)، ممكن نرجع أصفار أو الشرطات
    if (diff.isNegative) {
      return "00:00:00"; 
    }

    // 4. تنسيق الوقت (ساعة:دقيقة:ثانية) مع إضافة صفر على الشمال
    String h = diff.inHours.toString().padLeft(2, '0');
    String m = (diff.inMinutes % 60).toString().padLeft(2, '0');
    String s = (diff.inSeconds % 60).toString().padLeft(2, '0');

    return "$h:$m:$s";
    
  } catch (e) {
    // 5. في حالة حصل أي خطأ غير متوقع في الـ Parse
    return "--:--:--";
  }
}

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
