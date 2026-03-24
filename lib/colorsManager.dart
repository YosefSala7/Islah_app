import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF1F3B57); 
  static const Color secondary = Color(0xFF7FA9C9); 
  static const Color accent = Color(0xFFF4A825); 
  static const Color accentSoft = Color(0xFFFFD27A);
  static const Color grey = Color(0xFF8A7F86);
}
class LightColors {
  static const Color background = Color(0xFFF5F7FA);
  static const Color card = Color(0xFFFFFFFF);

  static const Color textPrimary = ColorManager.primary;
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color border = Color(0xFFE5E7EB);

  static const Color appBar = Color(0xFFFFFFFF);
  static const Color navBar = Color(0xFFFFFFFF);

  static const Color iconActive = ColorManager.accent;
  static const Color iconInactive = Color(0xFF9CA3AF);
}
class DarkColors {
  static const Color background = Color(0xFF0F172A);
  static const Color card = Color(0xFF1E293B);

  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);

  static const Color border = Color(0xFF334155);

  static const Color appBar = Color(0xFF1E293B);
  static const Color navBar = Color(0xFF1E293B);

  static const Color iconActive = ColorManager.accent;
  static const Color iconInactive = Color(0xFF64748B);
}

// --- Light Theme ---
final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColors.background,
  cardColor: LightColors.card,
  
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: LightColors.textPrimary), // النص الأساسي
    bodyMedium: TextStyle(color: LightColors.textSecondary), // النص الفرعي
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.appBar,
    foregroundColor: LightColors.textPrimary, // لون العناوين والأيقونات في الـ Appbar
    elevation: 0,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: LightColors.navBar,
    selectedItemColor: LightColors.iconActive,
    unselectedItemColor: LightColors.iconInactive,
  ),

  colorScheme: const ColorScheme.light(
    primary: ColorManager.primary,
    secondary: ColorManager.secondary,
    outline: LightColors.border, 
  ),
);

// --- Dark Theme ---
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColors.background,
  cardColor: DarkColors.card,

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: DarkColors.textPrimary),
    bodyMedium: TextStyle(color: DarkColors.textSecondary),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.appBar,
    foregroundColor: DarkColors.textPrimary,
    elevation: 0,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: DarkColors.navBar,
    selectedItemColor: DarkColors.iconActive,
    unselectedItemColor: DarkColors.iconInactive,
  ),

  colorScheme: const ColorScheme.dark(
    primary: ColorManager.primary,
    secondary: ColorManager.secondary,
    outline: DarkColors.border,
  ),
);