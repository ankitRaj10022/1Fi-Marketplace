import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryPurple = Color(0xFF6C63FF);
  static const Color darkNavy = Color(0xFF0F172A);
  static const Color greyText = Color(0xFF64748B);
  static const Color lightGreyBg = Color(0xFFF1F5F9);
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: lightGreyBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
        secondary: primaryPurple,
        surface: white,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.inter(color: darkNavy, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.inter(color: darkNavy),
        bodyMedium: GoogleFonts.inter(color: darkNavy),
        bodySmall: GoogleFonts.inter(color: greyText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryPurple,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: white),
        titleTextStyle: GoogleFonts.inter(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
