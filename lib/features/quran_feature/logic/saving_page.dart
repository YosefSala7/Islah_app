import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLastPage(int pageNumber) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('last_page', pageNumber);
}

Future<int> getLastPage() async {
  final prefs = await SharedPreferences.getInstance();
  int page = prefs.getInt('last_page') ?? 1;
  print("القيمة اللي اتقرت من الذاكرة: $page"); // شوف هيطبع كام أول ما تفتح
  return page;
}