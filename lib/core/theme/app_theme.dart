import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors for a stealthy, premium look
  static const Color background = Color(0xFF121212); // Deep dark grey
  static const Color surface = Color(0xFF1E1E1E); // Slightly lighter for cards
  static const Color primary = Color(0xFF5E5CE6); // Sleek Indigo accent
  static const Color accent = Color(0xFFFFD700); // Gold for premium/credits
  static const Color textMain = Color(0xFFF2F2F2);
  static const Color textMuted = Color(0xFFA0A0A0);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: surface,
      background: background,
    ),
    // Using Google Fonts (Inter) for that clean Dribbble UI vibe
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(color: textMain, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.inter(color: textMain),
      bodyMedium: GoogleFonts.inter(color: textMuted),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textMain),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Smooth rounded corners
      ),
    ),
  );
}