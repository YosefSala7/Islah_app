import 'package:app/features/quran_feature/UI/audio_player_dialog.dart';
import 'package:app/features/quran_feature/UI/tafsir_page.dart';
import 'package:app/features/quran_feature/logic/audio/audio_cubit.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qcf_quran_lite/qcf_quran_lite.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({super.key, required this.firstPage, this.firstVerse});
  int firstPage;
  int? firstVerse;
  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late int currentPage;
  late int currentSurahNumber;
  late String currentHezb;
  late String currentSurahName;
  late int currentJuzNumber;
  late PageController _controller;
  List<HighlightVerse> _activeHighlights = [];
  bool isSearchOpen = false;
  List<Map<String, dynamic>> searchResults = [];

  Widget _buildSearchOverlay(BuildContext context) {
    final sw = MediaQuery.sizeOf(context).width;
    final sh = MediaQuery.sizeOf(context).height;
    final ts = Theme.of(context);

    if (!isSearchOpen) return const SizedBox.shrink();

    return Container(
      color: ts.scaffoldBackgroundColor.withValues(alpha: 0.95),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: sh * 0.05,
              left: sw * 0.05,
              right: sw * 0.05,
            ),
            child: TextField(
              autofocus: true,
              style: ts.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "ابحث عن كلمة...",
                prefixIcon: Icon(Icons.search, color: ts.colorScheme.primary),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() {
                    isSearchOpen = false;
                    searchResults.clear();
                  }),
                ),
                filled: true,
                fillColor: ts.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                if (val.length > 2) {
                  setState(() {
                    searchResults = List<Map<String, dynamic>>.from(
                      searchWords(normalise(val))['result'],
                    );
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final item = searchResults[index];
                return ListTile(
                  title: Text(
                    item['text'],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "QCF_BSML",
                      fontSize: sw * 0.05,
                    ),
                  ),
                  subtitle: Text(
                    "${getSurahNameArabic(item['sora'])} - آية ${item['aya_no']}",
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    int p = getPageNumber(item['sora'], item['aya_no']);
                    _controller.jumpToPage(p - 1);
                    setState(() {
                      isSearchOpen = false;
                      searchResults.clear();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = widget.firstPage;
    currentHezb = getCurrentHizbTextForPage(currentPage);
    //[{surah: 5, start: 14, end: 17}]
    currentSurahNumber = getPageData(currentPage)[0]["surah"];
    currentSurahName = getSurahNameArabic(currentSurahNumber);
    currentJuzNumber = getJuzNumber(
      currentSurahNumber,
      getPageData(currentPage)[0]["start"],
    );
    _controller = PageController(initialPage: widget.firstPage - 1);
Future.delayed(Duration.zero, () {
  if (widget.firstVerse != null) {
    setState(() {
      _activeHighlights.add(
        HighlightVerse(
          verseNumber: widget.firstVerse!,
          page: currentPage + 1, 
          surah: currentSurahNumber,
          color: Theme.of(context).colorScheme.primary.withAlpha(113), 
        ),
      );
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _activeHighlights.clear();
        });
      }
    });
  }
});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioCubit(),
      child: Builder(
        builder: (parentContext) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.heightOf(context),
                    width: MediaQuery.widthOf(context),
                    child: QuranPageView(
                      onLongPress: (surahNumber, verseNumber, details) {
                        setState(() {
                          _activeHighlights.add(
                            HighlightVerse(
                              verseNumber: verseNumber,
                              page: currentPage + 1,
                              surah: surahNumber,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(113),
                            ),
                          );
                        });
                        showModalBottomSheet(
                          context: parentContext,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (buttomSheetContext) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "سورة ${getSurahNameArabic(surahNumber)} - آية $verseNumber",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.bookBookmark),
                                    title: Text("حفظ عند الآية"),
                                    onTap: () {
                                      BlocProvider.of<SavePageCubit>(
                                        context,
                                      ).savePageAndVerse(currentPage, verseNumber);
                                      
                                      ScaffoldMessenger.of(
                                        context,
                                      ).clearSnackBars();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "تم حفظ الصفحة عند $currentPage و الآية عند $verseNumber",
                                          ),
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          width: 200,
                                        ),
                                      );
                                      Navigator.pop(buttomSheetContext);
                                    },
                                  ),
                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.solidCopy),
                                    title: Text("نسخ الآية"),
                                    onTap: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: getVerse(
                                            surahNumber,
                                            verseNumber,
                                          ),
                                        ),
                                      );
                                      Navigator.pop(buttomSheetContext);
                                    },
                                  ),

                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.play),
                                    title: Text("استماع الآية"),
                                    onTap: () {
                                      Navigator.pop(buttomSheetContext);

                                      AudioPlayerDialog().showAudioPlayerDialog(
                                        parentContext,
                                        surah: surahNumber,
                                        ayah: verseNumber,
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: FaIcon(FontAwesomeIcons.bookOpen),
                                    title: Text("تفسير"),
                                    onTap: () {
                                      Navigator.pop(buttomSheetContext);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return TafsirPage(
                                              currentPage: currentPage,
                                              surahNumber: surahNumber,
                                              verseNumber: verseNumber,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ).whenComplete(() {
                          setState(() {
                            _activeHighlights = [];
                          });
                        });
                      },
                      pageController: _controller,
                      highlights: _activeHighlights,
                      onPageChanged: (page) {
                        int newSurahNum = getPageData(page)[0]["surah"];
                        String newSurahName = getSurahNameArabic(newSurahNum);
                        String newHezb = getCurrentHizbTextForPage(page);
                        int newJuz = ((page - 2) / 20).floor() + 1;
                        if (newSurahNum != currentSurahNumber ||
                            newHezb != currentHezb) {
                          setState(() {
                            currentPage = page;
                            currentSurahName = newSurahName;
                            currentHezb = newHezb;
                            currentSurahNumber = newSurahNum;
                            currentJuzNumber = newJuz;
                          });
                        } else {
                          setState(() {
                            currentPage = page;
                          });
                        }
                      },
                      topBar:
                          MediaQuery.sizeOf(context).width >
                              MediaQuery.sizeOf(context).height
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              width: MediaQuery.sizeOf(context).width,

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back),
                                    ),
                                    Text(
                                      "الجزء ${currentJuzNumber == 0 ? 1 : currentJuzNumber}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontFamily: "QCF_Surah",
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontSize:
                                                MediaQuery.sizeOf(context).width *
                                                0.04,
                                          ),
                                    ),
                                    
                                    Text(
                                      "سورة $currentSurahName",
                                      style: Theme.of(context).textTheme.bodyLarge
                                          ?.copyWith(
                                            fontFamily: "QCF_Surah",
                                            fontSize:
                                                MediaQuery.sizeOf(context).width *
                                                0.05,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isSearchOpen = true;
                                        });
                                      },
                                      icon: Icon(Icons.search),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      bottomBar: SizedBox(
                        height:
                            MediaQuery.sizeOf(context).width >
                                MediaQuery.sizeOf(context).height
                            ? MediaQuery.sizeOf(context).height * 0.08
                            : MediaQuery.sizeOf(context).height * 0.06,
                        width: MediaQuery.sizeOf(context).width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!(MediaQuery.sizeOf(context).width >
                                  MediaQuery.sizeOf(context).height))
                                Text(
                                  currentHezb,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontFamily: "QCF_Surah",
                                        fontSize:
                                            MediaQuery.sizeOf(context).width *
                                            0.04,
                                      ),
                                ),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.sizeOf(context).width * 0.03,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary.withAlpha(125),
                                  ),
                                ),
                                child: Text(
                                  currentPage.toString(),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<SavePageCubit>(
                                    context,
                                  ).savePageAndVerse(currentPage, 0);
                                  ScaffoldMessenger.of(
                                    context,
                                  ).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "تم حفظ الصفحة عند $currentPage",
                                      ),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      width: 200,
                                    ),
                                  );
                                },
                                icon: FaIcon(FontAwesomeIcons.solidBookmark,size:20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildSearchOverlay(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
