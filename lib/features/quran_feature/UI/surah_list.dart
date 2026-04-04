import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SurahIndexList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: 114,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        int surahNumber = index + 1;
        return ListTile(
          leading: Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.secondary.withOpacity(0.1),
              border: Border.all(
                color: theme.colorScheme.secondary.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Text(
              "$surahNumber",
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo",
              ),
            ),
          ),
          title: Text(
            quran.getSurahNameArabic(surahNumber),
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
            ),
          ),
          subtitle: Text(
            "${quran.getPlaceOfRevelation(surahNumber).tr()} - آياتها ${quran.getVerseCount(surahNumber)}",
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontFamily: "Cairo",
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: theme.colorScheme.primary,
          ),
          onTap: () {
            int firstPage = quran.getSurahPages(surahNumber).first;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranReaderScreen(
                  initialPage: firstPage,
                ),
              ),
            );
          },
        );
      },
    );
  }
}