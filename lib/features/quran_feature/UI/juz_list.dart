import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter_animate/flutter_animate.dart';

class JuzIndexList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 30,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      itemBuilder: (context, index) {
        int juzNumber = index + 1;
        var juzData = quran.getSurahAndVersesFromJuz(juzNumber);
        int firstSurahInJuz = juzData.keys.first;
        int firstPageInJuz = ((juzNumber - 1) * 20) + 1;

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: theme.dividerColor.withAlpha(30)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            title: Text(
              "الجزء $juzNumber",
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Almarai",
              ),
            ),
            subtitle: Text(
              "بداية من سورة ${quran.getSurahNameArabic(firstSurahInJuz)}",
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontFamily: "Almarai",
              ),
            ),
            trailing: Icon(
              CupertinoIcons.book_fill,
              color: theme.colorScheme.primary,
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) =>
                      QuranScreen(firstPage: firstPageInJuz,),
                ),
              );
            },
          ),
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
            );
      },
    );
  }
}