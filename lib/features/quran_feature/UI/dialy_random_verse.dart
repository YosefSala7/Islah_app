import 'package:app/core/components/card.dart';
import 'package:app/features/notifcations_feature/noti_service.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/fetchPrayerTimesAPI.dart';
import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

class DialyRandomVerse extends StatelessWidget {
  const DialyRandomVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDailyVerse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("حدث خطأ ما");
        } else {
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return QuranScreen(
                        firstPage:
                            (quran.getPageNumber(
                              data["surahNumber"],
                              data["verseNumber"],
                            )) -
                            1,
                      );
                    },
                  ),
                );
              },
              child: MyCard(
                25,
                MediaQuery.heightOf(context) / 4,
                MediaQuery.widthOf(context),
                Theme.of(context).cardColor,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withAlpha(120),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "سورة ${quran.getSurahNameArabic(data["surahNumber"])}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(width: 7),
                                  Icon(
                                    Icons.menu_book,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.color!,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.heightOf(context) / 9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quran.getVerse(
                                data["surahNumber"],
                                data["verseNumber"],
                                verseEndSymbol: true,
                              ),
                              style: TextStyle(
                                fontFamily: "Amiri",
                                fontWeight: FontWeight.w600,
                                fontSize: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.fontSize!,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.color!,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withAlpha(120),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اَية اليوم",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(width: 7),
                                  Icon(
                                    Icons.book_rounded,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.color!,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

Future<void> getRandomeVerse() async {
  var randomData = quran.RandomVerse();
  while (randomData.verse.length > 122) {
    randomData = quran.RandomVerse();
  }
  int verseNumber = randomData.verseNumber;
  int surahNumber = randomData.surahNumber;
  await saveDailyVerse(verseNumber, surahNumber);
}

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
      time: "06:00",
    );
    await LocalNotiService().scheduleAzkarNoti(
      id: 6,
      title: "اذكار المساء",
      body: "شمس اليوم غابت فأنر ,قلبك بذكر الله",
      time: "15:00",
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
