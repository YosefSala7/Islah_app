import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<SavePageCubit, PageState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            label: Text(state.page > 1 ? "متابعة الختمة" : "ابدأ ختمة"),
            onPressed: () {
              final int targetPage = context.read<SavePageCubit>().state.page;
              context.read<SavePageCubit>().savePage(targetPage);
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) =>
                      QuranReaderScreen(initialPage: targetPage),
                ),
              );
            },
          );
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height:
                MediaQuery.sizeOf(context).height *
                0.88, // طريقة مختصرة للارتفاع
            child: QuranIndexScreen(),
          ),
        ],
      ),
    );
  }
}
