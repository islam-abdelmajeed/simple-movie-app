import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static const String _themeKey = 'is_dark_theme';
  static SharedPreferences? _prefs;
  static final ValueNotifier<bool> themeNotifier = ValueNotifier<bool>(false);

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    themeNotifier.value = isDarkTheme;
  }

  static bool get isDarkTheme {
    return _prefs?.getBool(_themeKey) ?? false;
  }

  static Future<void> setDarkTheme(bool isDark) async {
    await _prefs?.setBool(_themeKey, isDark);
    themeNotifier.value = isDark;
  }

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFF6F00),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFF6F00), foregroundColor: Color(0xFFFFFFFF), elevation: 0),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Color(0xFF000000), fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Color(0xDE000000), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xDE000000), fontSize: 14),
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFFF6F00),
      secondary: const Color(0xFFFF6F00),
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF000000),
      onPrimary: const Color(0xFFFFFFFF),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E), foregroundColor: Color(0xFFFFFFFF), elevation: 0),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Color(0xB3FFFFFF), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xB3FFFFFF), fontSize: 14),
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF49A565),
      secondary: const Color(0xFF81C784),
      surface: const Color(0xFF1E1E1E),
      onSurface: const Color(0xFFFFFFFF),
      onPrimary: const Color(0xFFFFFFFF),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
