import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:gap/gap.dart';
import 'package:quran/quran.dart' as quran;

class SurahIndexList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 114,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        int surahNumber = index + 1;
        return GestureDetector(
          onTap: () {
            int firstPage = quran.getSurahPages(surahNumber).first;
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) =>
                    QuranScreen(firstPage: firstPage),
              ),
            );
          },
          child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 25, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withAlpha(50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Gap(25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quran.getSurahNameArabic(surahNumber),
                                  style: TextStyle(
                                    color: theme.textTheme.bodyLarge?.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Almarai",
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FlutterIslamicIcons.solidKaaba,
                                      size: 15,
                                    ),
                                    Gap(5),
                                    Text(
                                      quran
                                          .getPlaceOfRevelation(surahNumber)
                                          .tr(),
                                      style: TextStyle(
                                        color: theme.textTheme.bodySmall?.color,
                                        fontFamily: "Almarai",
                                      ),
                                    ),
                                    Gap(5),
                                    Text(
                                      "-",
                                      style: TextStyle(
                                        color: theme.textTheme.bodySmall?.color,
                                        fontFamily: "Almarai",
                                      ),
                                    ),
                                    Gap(5),
                                    Icon(
                                      FlutterIslamicIcons.solidQuran2,
                                      size: 15,
                                    ),
                                    Gap(5),
                                    Text(
                                      "آياتها ${quran.getVerseCount(surahNumber)}",
                                      style: TextStyle(
                                        color: theme.textTheme.bodySmall?.color,
                                        fontFamily: "Almarai",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.heightOf(context) / 45,
                    left: MediaQuery.widthOf(context) / 1.18,
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary,
                      ),
                      child: Text(
                        "$surahNumber",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Almarai",
                        ),
                      ),
                    ),
                  ),
                ],
              )
              .animate()
              .fade(duration: 350.ms, curve: Curves.easeIn)
              .slideX(
                begin: 0.3,
                end: 0,
                duration: 450.ms,
                curve: Curves.easeOutCubic,
              )
              .shimmer(
                delay: 50.ms,
                duration: 1000.ms,
                color: theme.colorScheme.primary.withAlpha(60),
              ),
        );
      },
    );
  }
}
