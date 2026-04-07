import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:app/features/quran_feature/logic/saving_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quran/quran.dart' as quran;

class QuranReaderScreen extends StatefulWidget {
  final int initialPage;

  const QuranReaderScreen({super.key, required this.initialPage});

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  int _currentPage = 1;
  double _fontSize = 23;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage - 1);
  }

  String _getFilteredVerses(int surah, int start, int end) {
    String fullText = "";
    for (int i = start; i <= end; i++) {
      String verse = quran.getVerse(surah, i, verseEndSymbol: true);
      if (i == 1 && surah != 1 && surah != 9) {
        verse = verse.trim();
        if (verse.startsWith("بِسْمِ")) {
          int basmalaLength = quran.basmala.length + 1;
          if (verse.length > basmalaLength) {
            verse = verse.substring(basmalaLength).trim();
          }
        }
      }
      fullText += "$verse ";
    }
    return fullText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        buttonSize: const Size(45, 45),
        childrenButtonSize: const Size(40, 40),
        closeManually: true,
        icon: Icons.settings,
        activeIcon: Icons.close,

        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,

        children: [
          SpeedDialChild(
            child: Icon(Icons.text_increase),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: Theme.of(context).iconTheme.color,
            onTap: () {
              setState(() {
                if (_fontSize < 30) _fontSize += 1;
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.text_decrease),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor: Theme.of(context).iconTheme.color,
            onTap: () {
              setState(() {
                if (_fontSize > 20) _fontSize -= 1;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index + 1;
            });
          },
          itemCount: 604,
          itemBuilder: (context, index) {
            List pageData = quran.getPageData(index + 1);

            return Column(
              children: [
                buildHeader(_currentPage, theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      children: pageData.map((data) {
                        int surahNum = data['surah'];
                        int startVerse = data['start'];
                        int endVerse = data['end'];

                        return Column(
                          children: [
                            if (startVerse == 1) ...[
                              _buildSurahBanner(surahNum, theme),
                              if (surahNum != 1 && surahNum != 9)
                                _buildBasmalah(theme),
                            ],
                            Text(
                              _getFilteredVerses(
                                surahNum,
                                startVerse,
                                endVerse,
                              ),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: _fontSize,
                                height: 1.45,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "$_currentPage",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildHeader(int currentPage, ThemeData theme) {
    int firstSurah = quran.getPageData(currentPage + 1).first['surah'];
    int juz = quran.getJuzNumber(
      firstSurah,
      quran.getPageData(currentPage).first['start'],
    );
    return Container(
      height: MediaQuery.heightOf(context) / 16,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor.withAlpha(127),
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withAlpha(80)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 20,
          ),

          Text(
            "الجزء $juz",
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 16,
              color: theme.colorScheme.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  saveLastPage(_currentPage);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم حفظ الصفحة عند $currentPage"),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      width: 200,
                    ),
                  );
                },
                icon: Icon(Icons.bookmark_add_outlined),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QuranScreen(firstPage: currentPage - 1);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.menu_book),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSurahBanner(int surahNumber, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.1),
        border: Border.symmetric(
          horizontal: BorderSide(color: theme.colorScheme.primary, width: 1.2),
        ),
      ),
      child: Text(
        "سورة ${quran.getSurahNameArabic(surahNumber)}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildBasmalah(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        quran.basmala,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
