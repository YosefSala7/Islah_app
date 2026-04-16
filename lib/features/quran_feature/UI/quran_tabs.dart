import 'package:app/features/quran_feature/UI/juz_list.dart';
import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:app/features/quran_feature/UI/surah_list.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

class QuranIndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      "تنبيه",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Almarai",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      "هل تريد بدأ ختمة جديدة؟",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Almarai"),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "لا",
                          style: TextStyle(fontFamily: "Almarai"),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          int firstPage = quran.getSurahPages(1).first;
                          BlocProvider.of<SavePageCubit>(context).newKhatma();
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuranReaderScreen(initialPage: firstPage),
                            ),
                          );
                        },
                        child: Text(
                          "نعم",
                          style: TextStyle(fontFamily: "Almarai"),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
          title: Text(
            "المصحف الشريف",
            style: TextStyle(
              fontFamily: "ReemKufi",
              color: theme.appBarTheme.foregroundColor,
              fontSize: 30
            ),
          ),
          centerTitle: true,
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: "السور"),
              Tab(text: "الأجزاء"),
            ],
            indicatorColor: theme.colorScheme.secondary,
            indicatorWeight: 3,
            labelColor: theme.appBarTheme.foregroundColor,
            unselectedLabelColor: theme.appBarTheme.foregroundColor?.withAlpha(
              127,
            ),
            labelStyle: TextStyle(
              fontFamily: "Almarai",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Almarai",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: TabBarView(children: [SurahIndexList(), JuzIndexList()]),
      ),
    );
  }
}
