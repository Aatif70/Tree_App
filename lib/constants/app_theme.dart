import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color lightMintGreen = Color(0xFFE8F5E9);
  static const Color softGreen = Color(0xFFA5D6A7);
  static const Color mediumGreen = Color(0xFF81C784);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFFC8E6C9);
  static const Color backgroundGrey = Color(0xFFF0F4F8);
  static const Color white = Colors.white;

  // Gradients
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightMintGreen, softGreen],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkGreen, softGreen],
  );

  // Text Styles
  static TextStyle get headingStyle => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: darkGreen,
      );

  static TextStyle get subheadingStyle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkGreen,
      );

  static TextStyle get bodyStyle => GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black87,
      );

  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: white,
      );

  static TextStyle get smallTextStyle => GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black54,
      );

  // Theme
  static ThemeData get theme => ThemeData(
        primaryColor: darkGreen,
        scaffoldBackgroundColor: white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkGreen,
          primary: darkGreen,
          secondary: softGreen,
          tertiary: mediumGreen,
          surface: white,
        ),
        textTheme: TextTheme(
          headlineLarge: headingStyle,
          headlineMedium: subheadingStyle,
          bodyLarge: bodyStyle,
          bodyMedium: buttonTextStyle,
          bodySmall: smallTextStyle,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkGreen,
            foregroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: darkGreen, width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
      );
} 