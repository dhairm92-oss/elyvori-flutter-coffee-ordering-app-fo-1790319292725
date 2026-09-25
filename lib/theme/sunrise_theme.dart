import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SunriseTheme {
  static const Color primary = Color(0xFFD35400); // Warm amber/coffee orange
  static const Color secondary = Color(0xFF6E2C00); // Rich espresso
  static const Color background = Color(0xFFFAF9F6); // Soft cream
  static const Color surface = Colors.white;
  static const Color textMain = Color(0xFF2C1D0C);
  static const Color textMuted = Color(0xFF8C7A6B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        background: background,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: textMain,
        displayColor: textMain,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: IconThemeData(color: textMain),
        titleTextStyle: TextStyle(
          color: textMain,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
