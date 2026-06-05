import 'package:app/features/notifcations_feature/noti_service.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/fetchPrayerTimesAPI.dart';
import 'package:app/features/quran_feature/UI/dialy_random_verse.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> scheduelDailyTasks() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String today = DateTime.now().toString().split(" ")[0];
  String? lastRunDate = prefs.getString("lastRunDate");
  var data = await getFallbackData();
  if (lastRunDate == null || lastRunDate != today) {
    await getRandomeVerse();
    await LocalNotiService().scheduleAzkarNoti(
      id: 5,
      title: "اذكار الصباح",
      body: "ابدأ يومك بذكر الله",
      time: "05:00",
    );
    await LocalNotiService().scheduleAzkarNoti(
      id: 6,
      title: "اذكار المساء",
      body: "شمس اليوم غابت فأنر ,قلبك بذكر الله",
      time: "17:00",
    );
    if (data != null) {
      await LocalNotiService().schedulePrayerNoti(
        id: 0,
        title: "الفجر",
        body: "حان الآن موعد صلاة الفجر",
        time: data.data.times.fajr,
      );
      await LocalNotiService().schedulePrayerNoti(
        id: 1,
        title: "الظهر",
        body: "حان الآن موعد صلاة الظهر",
        time: data.data.times.dhuhr,
      );
      await LocalNotiService().schedulePrayerNoti(
        id: 2,
        title: "العصر",
        body: "حان الآن موعد صلاة العصر",
        time: data.data.times.asr,
      );
      await LocalNotiService().schedulePrayerNoti(
        id: 3,
        title: "المغرب",
        body: "حان الآن موعد صلاة المغرب",
        time: data.data.times.maghrib,
      );
      await LocalNotiService().schedulePrayerNoti(
        id: 4,
        title: "العشاء",
        body: "حان الآن موعد صلاة العشاء",
        time: data.data.times.isha,
      );
      await LocalNotiService().scheduleWeeklyNoti(
        id: 7,
        title: "سورة الكهف 📖",
        body: "نورٌ ما بين الجمعتين، لا تنسى قراءتها اليوم.",
        time: "10:00",
        dayOfWeek: DateTime.friday,
      );
      await LocalNotiService().scheduleWeeklyNoti(
        id: 8,
        title: "لا تنسى صيام غداً الأثنين",
        body: "غداً الأثنين.. صيام سُنّة النبي ﷺ.",
        time: "22:00",
        dayOfWeek: DateTime.sunday,
      );
      await LocalNotiService().scheduleWeeklyNoti(
        id: 9,
        title: "لا تنسى صيام غداً الخميس",
        body: "غداً الخميس.. صيام سُنّة النبي ﷺ.",
        time: "22:00",
        dayOfWeek: DateTime.wednesday,
      );
    }
    await prefs.setString("lastRunDate", today);
  }
}

Future<void> saveDailyVerse(int verseNumber, int surahNumber) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('verseNumber', verseNumber);
  await prefs.setInt('surahNumber', surahNumber);
}

Future<Map<String, dynamic>> getDailyVerse() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  int verseNumber = prefs.getInt('verseNumber') ?? 0;
  int surahNumber = prefs.getInt('surahNumber') ?? 0;

  return {'verseNumber': verseNumber, 'surahNumber': surahNumber};
}
