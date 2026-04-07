import 'package:flutter/material.dart';

// --- Light Theme ---
final lightTheme = ThemeData(
  fontFamily: "Cairo",
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF0F4F8), // خلفية سماوي فاتح جداً
  cardColor: Colors.white,

  // --- ألوان الأيقونات ---
  
  iconTheme: const IconThemeData(
    color: Color(0xFF1A365D),
    size: 24,
  ), // كحلي غامق
  // --- ألوان الزراير ---
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2B6CB0), // خلفية الزرار (أزرق زاهي)
      foregroundColor: Colors.white, // لون نص الزرار
      textStyle: const TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
textTheme: const TextTheme(
  bodyLarge: TextStyle(
    color: Color(0xFF1A365D), 
    fontSize: 26, 
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  ),


  bodyMedium: TextStyle(
    color: Color(0xFF2D3748), 
    fontSize: 17, 
    fontWeight: FontWeight.w500,
  ),

  bodySmall: TextStyle(
    color: Color(0xFF718096),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2B6CB0),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // خلفية الناف بار
    selectedItemColor: Color(0xFF2B6CB0), // لون الأيقونة المختارة (أزرق زاهي)
    unselectedItemColor: Color(
      0xFF718096,
    ), // لون الأيقونة غير المختارة (رمادي مزرق)
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: "Cairo",
      fontWeight: FontWeight.bold,
    ),
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
  iconTheme: const IconThemeData(
    color: Color(0xFF63B3ED),
    size: 24,
  ), // أزرق سماوي ينور في الضلمة
  // --- ألوان الزراير ---
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF63B3ED), // زرار فاتح عشان يبان في الغامق
      foregroundColor: const Color(
        0xFF0A192F,
      ), // نص كحلي غامق فوق الزرار الفاتح
      textStyle: const TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),



textTheme: const TextTheme(
  bodyLarge: TextStyle(
    color: Color(0xFFE6F1FF), // أبيض ثلجي نقي
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),

  // الكلام العادي في الأبلكيشن (واضح وهادي)
  bodyMedium: TextStyle(
    color: Color(0xFFCCD6F6), // رمادي فاتح مائل للزرقة (Slate)
    fontSize: 17,
    fontWeight: FontWeight.w500,
  ),

  // الحاجات الصغيرة والتفاصيل
  bodySmall: TextStyle(
    color: Color(0xFF8892B0), // رمادي خافت (عشان يقلل التشتت البصري)
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0A192F),
    foregroundColor: Color(0xFF63B3ED),
    elevation: 0,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF112240), // كحلي أغمق درجة من الكروت
    selectedItemColor: Color(0xFF63B3ED), // لون الأيقونة المختارة (لبني فاتح)
    unselectedItemColor: Color(0xFF8892B0), 
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: "Cairo",
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(fontFamily: "Cairo"),
  ),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF63B3ED),
    secondary: Color(0xFF2B6CB0),
    surface: Color(0xFF172A45),
  ),
);
