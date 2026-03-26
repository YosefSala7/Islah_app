import 'package:app/core/Global%20State%20Managment/darkModeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkCubit extends Cubit<DarkModeState> {
  DarkCubit(bool isDark) : super(DarkModeInitial(isDark));
  void onClick() async{
    bool isDark = await loadThemeMode();
    emit(DarkModeUpdated(DarkStatus: !isDark));
    saveThemeMode(state.isDark);
  }
}

Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", isDark);
  }

  Future<bool> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDarkMode") ?? false;
  }
