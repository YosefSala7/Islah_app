import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranPage extends StatelessWidget {
  QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            context.watch<SavePageCubit>().state.page > 1
                ? const Text("متابعة الختمة")
                : const Text("ابدأ ختمة"),
          ],
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => QuranReaderScreen(
                initialPage: context.watch<SavePageCubit>().state.page,
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height:
                MediaQuery.heightOf(context) -
                MediaQuery.heightOf(context) / 9,
            child: QuranIndexScreen(),
          ),
        ],
      ),
    );
  }
}
