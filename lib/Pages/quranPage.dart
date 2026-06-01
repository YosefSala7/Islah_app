import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavePageCubit, PageState>(
      builder: (context, state) {
        context.read<SavePageCubit>().getPageAndVerse();
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: [
                (state.page ?? 1) > 1
                    ? const Text("متابعة الختمة")
                    : const Text("ابدأ ختمة"),
              ],
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => QuranScreen(firstPage: state.page ?? 1,firstVerse: state.verse ?? 1,),
                ),
              );
            },
          ),
          body: Column(
            children: [
              SizedBox(
                height:
                    MediaQuery.heightOf(context) -
                    MediaQuery.heightOf(context) / 12,
                child: QuranIndexScreen(),
              ),
            ],
          ),
        );
      },
    );
  }
}
