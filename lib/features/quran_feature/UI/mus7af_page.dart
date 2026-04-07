import 'package:app/features/quran_feature/UI/audio_player_dialog.dart';
import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:app/features/quran_feature/logic/audio/audio_cubit.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_pages_with_ayah_detector/quran_pages_with_ayah_detector.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({super.key, required this.firstPage});
  int firstPage;

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.firstPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.bookmark_add_outlined),
        onPressed: () {
          BlocProvider.of<SavePageCubit>(context).savePage(currentPage);
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
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.heightOf(context),
          width: MediaQuery.widthOf(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: BlocProvider(
                        create: (context) => AudioCubit(),
                        child: Builder(
                          builder: (newContext) {
                            return BlocProvider.value(
                              value: newContext.read<AudioCubit>(),
                              child: Builder(
                                builder: (ctx) {
                                  return QuranPageView(
                                    initialPage: widget.firstPage,
                                    fontFamilyName: "QCF_P000",
                                    isReversed: false,
                                    onAyahTap: (surah, ayah, page) {
                                      print(
                                        'تم الضغط على سورة $surah، آية $ayah، صفحة $page',
                                      );
                                    },
                                    searchIconColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    searchSheetIconsColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    searchResultTextColor:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color ??
                                        Colors.white,
                                    searchResultInfoColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    searchFieldHintTextColor:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color ??
                                        Colors.grey,
                                    searchFieldTextColor:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color ??
                                        Colors.white,
                                    searchFieldHandleColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    searchFieldBackgroundColor:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(context).cardColor
                                        : const Color(0xFFF5F5F5),
                                    searchFieldDarkBackgroundColor: Theme.of(
                                      context,
                                    ).cardColor,
                                    onPageChanged: (page) {
                                      setState(() {
                                        currentPage = page + 1;
                                      });
                                      print("أنت الآن في صفحة: $page");
                                    },
                                    quranTextColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    topBarTextColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    pageNumberColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.color!,
                                    pageNumberDesign: PageNumberDesign.glass,

                                    customAyahActions: [
                                      AyahActionOption(
                                        title: 'تشغيل الاية',
                                        icon: Icons.play_arrow,
                                        onPress: (surah, ayah, page) {
                                          AudioPlayerDialog()
                                              .showAudioPlayerDialog(
                                                newContext,
                                                surah: surah,
                                                ayah: ayah,
                                              );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: MediaQuery.widthOf(context) * 0.34,
                top: MediaQuery.heightOf(context) * 0.009,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  iconSize: 20,
                ),
              ),
              Positioned(
                left: MediaQuery.widthOf(context) * 0.34,
                top: MediaQuery.heightOf(context) * 0.007,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return QuranReaderScreen(
                            initialPage: currentPage + 1,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.menu_book,
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
