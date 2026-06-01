import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLastPage(int pageNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('last_page', pageNumber);
  print(prefs.getInt('last_page') == pageNumber);
}

Future<int> getLastPage() async {
  final prefs = await SharedPreferences.getInstance();
  int page = prefs.getInt('last_page') ?? 1;
  print("القيمة اللي اتقرت من الذاكرة: $page"); // شوف هيطبع كام أول ما تفتح
  return page;
}
Future<void> saveVerse(int verseNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('last_verse', verseNumber);
  print(prefs.getInt('last_verse') == verseNumber);
}

Future<int> getLastVerse() async {
  final prefs = await SharedPreferences.getInstance();
  int verse = prefs.getInt('last_verse') ?? 0;
  print("القيمة اللي اتقرت من الذاكرة: $verse"); // شوف هيطبع كام أول ما تفتح
  return verse;
}