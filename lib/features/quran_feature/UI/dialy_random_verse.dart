import 'package:app/core/components/card.dart';
import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

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
  await saveDailyVerse( verseNumber, surahNumber);
}

Future<void> scheduelDailyRandomVerseTask() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String today = DateTime.now().toString().split(" ")[0];
  String? lastRunDate = prefs.getString("lastRunDate");
  if (lastRunDate == null || lastRunDate != today) {
    await getRandomeVerse();
    await prefs.setString("lastRunDate", today);
  }
}

Future<void> saveDailyVerse(
  int verseNumber,
  int surahNumber,
) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('verseNumber', verseNumber);
  await prefs.setInt('surahNumber', surahNumber);
}

Future<Map<String, dynamic>> getDailyVerse() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  int verseNumber = prefs.getInt('verseNumber') ?? 0;
  int surahNumber = prefs.getInt('surahNumber') ?? 0;

  return {
    'verseNumber': verseNumber,
    'surahNumber': surahNumber,
  };
}
