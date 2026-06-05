import 'package:app/core/components/card.dart';
import 'package:app/core/scheduel_Daily_Tasks.dart';
import 'package:app/features/notifcations_feature/noti_service.dart';
import 'package:app/features/prayer%20times%20&%20hijri%20date/data/repos/fetchPrayerTimesAPI.dart';
import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:flutter/cupertino.dart';
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
                        firstVerse: data["verseNumber"],
                        firstPage:
                            (quran.getPageNumber(
                              data["surahNumber"],
                              data["verseNumber"],
                            ))
                            ,
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
                                    CupertinoIcons.book_solid,
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
                                    CupertinoIcons.quote_bubble_fill,
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
