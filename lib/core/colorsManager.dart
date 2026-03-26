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
  fontFamily: "Cairo",
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF0F4F8), // خلفية سماوي فاتح جداً
  cardColor: Colors.white,
  
  // --- ألوان الأيقونات ---
  iconTheme: const IconThemeData(color: Color(0xFF1A365D), size: 24), // كحلي غامق

  // --- ألوان الزراير ---
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2B6CB0), // خلفية الزرار (أزرق زاهي)
      foregroundColor: Colors.white,            // لون نص الزرار
      textStyle: const TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF1A365D),fontWeight: FontWeight.bold,fontSize: 20), // نص كحلي غامق
    bodyMedium: TextStyle(color: Color(0xFF4A5568)), // نص رمادي مزرق
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2B6CB0), // أزرق براند
    foregroundColor: Colors.white, 
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  backgroundColor: Colors.white, // خلفية الناف بار
  selectedItemColor: Color(0xFF2B6CB0), // لون الأيقونة المختارة (أزرق زاهي)
  unselectedItemColor: Color(0xFF718096), // لون الأيقونة غير المختارة (رمادي مزرق)
  showUnselectedLabels: true,
  selectedLabelStyle: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(fontFamily: "Cairo"),
),

  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2B6CB0),
    secondary: Color(0xFF63B3ED), // أزرق فاتح للتفاصيل
    surface: Colors.white,
  ),
);

// --- Dark Theme ---
final darkTheme = ThemeData(
  fontFamily: "Cairo",
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0A192F), // كحلي غامق جداً (ليلي)
  cardColor: const Color(0xFF172A45), // أزرق غامق للكروت

  // --- ألوان الأيقونات ---
  iconTheme: const IconThemeData(color: Color(0xFF63B3ED), size: 24), // أزرق سماوي ينور في الضلمة

  // --- ألوان الزراير ---
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF63B3ED), // زرار فاتح عشان يبان في الغامق
      foregroundColor: const Color(0xFF0A192F), // نص كحلي غامق فوق الزرار الفاتح
      textStyle: const TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFE6F1FF),fontWeight: FontWeight.bold,fontSize: 20), // نص أبيض مزرق
    bodyMedium: TextStyle(color: Color(0xFF8892B0)), // نص رمادي هادئ
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0A192F),
    foregroundColor: Color(0xFF63B3ED),
    elevation: 0,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  backgroundColor: Color(0xFF112240), // كحلي أغمق درجة من الكروت
  selectedItemColor: Color(0xFF63B3ED), // لون الأيقونة المختارة (لبني فاتح)
  unselectedItemColor: Color(0xFF8892B0), // لون الأيقونة غير المختارة
  showUnselectedLabels: true,
  selectedLabelStyle: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(fontFamily: "Cairo"),
),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF63B3ED),
    secondary: Color(0xFF2B6CB0),
    surface: const Color(0xFF172A45),
  ),
);