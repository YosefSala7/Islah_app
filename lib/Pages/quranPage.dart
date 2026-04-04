import 'package:app/features/quran_feature/logic/saving_page.dart';
import 'package:app/features/quran_feature/UI/quran_page.dart';
import 'package:app/features/quran_feature/UI/quran_tabs.dart';
import 'package:flutter/material.dart';

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
  }

  Future<void> loadLastPage() async {
    _lastPage = await getLastPage();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final int initialPage = _lastPage ?? 1;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            initialPage > 1 ? const Text("متابعة الختمة") : const Text("ابدأ ختمة"),
          ],
        ),

        onPressed: () async {
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => QuranReaderScreen(initialPage: initialPage),
            ),
          );
          await loadLastPage();
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height:
                MediaQuery.heightOf(context) - MediaQuery.heightOf(context) / 9,
            child: QuranIndexScreen(),
          ),
        ],
      ),
    );
  }
}
