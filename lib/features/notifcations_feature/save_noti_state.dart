import 'package:shared_preferences/shared_preferences.dart';

void saveNoti(bool isAllowed) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool("isNotiAllowed", isAllowed);
}

Future<bool> getNoti() async {
  var prefs = await SharedPreferences.getInstance();
  return  prefs.getBool("isNotiAllowed") ?? false;
}
