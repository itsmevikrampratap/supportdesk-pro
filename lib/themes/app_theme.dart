import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF2563EB),     // Indigo Blue
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFDBEAFE),
      secondary: const Color(0xFF4F46E5),   // Deep Royal
      surface: const Color(0xFFFFFFFF),
      background: const Color(0xFFF8FAFC),  // Light Gray
      onBackground: const Color(0xFF0F172A), // Slate Dark Text
      onSurface: const Color(0xFF1E293B),
      error: const Color(0xFFEF4444),       // Danger Alert
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF0F172A),
      elevation: 0,
      shape: Border(
        bottom: BorderSide(color: Color(0xFFE2E8F0)),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF334155)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF475569)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF60A5FA),     // Indigo Light Blue
      onPrimary: const Color(0xFF0F172A),
      primaryContainer: const Color(0xFF1E293B),
      secondary: const Color(0xFF818CF8),
      surface: const Color(0xFF1E293B),     // Slate Dark Card
      background: const Color(0xFF0F172A),  // Deep Background
      onBackground: const Color(0xFFF8FAFC),
      onSurface: const Color(0xFFF1F5F9),
      error: const Color(0xFFF87171),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B),
      foregroundColor: Color(0xFFF8FAFC),
      elevation: 0,
      shape: Border(
        bottom: BorderSide(color: Color(0xFF334155)),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFF8FAFC)),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFF8FAFC)),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFF1F5F9)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFCBD5E1)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
    ),
  );
}