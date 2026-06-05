import 'package:app/features/quran_feature/UI/mus7af_page.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_cubit.dart';
import 'package:app/ads/after_quran_ad.dart';
import 'package:app/features/quran_feature/logic/saving_page.dart';
import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  int? _lastPage;

  @override
  void initState() {
    super.initState();
    loadLastPage();
    AfterQuranAd.loadInterstitial();
  }

  Future<void> loadLastPage() async {
    _lastPage = await getLastPage();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavePageCubit, PageState>(
      builder: (context, state) {
        context.read<SavePageCubit>().getPageAndVerse();
        return SafeArea(
          child: Scaffold(
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
                      MediaQuery.heightOf(context) / 8.5,
                  child: QuranIndexScreen(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
