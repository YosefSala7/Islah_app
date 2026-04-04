import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class JuzIndexList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: 30,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        int juzNumber = index + 1;

        var juzData = quran.getSurahAndVersesFromJuz(juzNumber);
        int firstSurahInJuz = juzData.keys.first;

        int firstPageInJuz = ((juzNumber - 1) * 20) + 2;

        return ListTile(
          title: Text(
            "الجزء $juzNumber",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 23,
              fontFamily: "Cairo",
            ),
          ),
          subtitle: Text(
            "بداية من سورة ${quran.getSurahNameArabic(firstSurahInJuz)}",
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontFamily: "Cairo",
            ),
          ),
          trailing: Icon(
            Icons.chrome_reader_mode_outlined,
            color: theme.colorScheme.primary,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuranReaderScreen(initialPage: firstPageInJuz),
              ),
            );
          },
        );
      },
    );
  }
}
