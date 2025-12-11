import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Colors ---
  
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF0EA5E9); // Primary Blue
  static const Color _lightSuccess = Color(0xFF10B981); // Success Green
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFF8FAFC);
  static const Color _lightText = Color(0xFF0F172A);
  static const Color _lightError = Color(0xFFEF4444); // Standard error red

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF38BDF8); // Primary Blue
  static const Color _darkSuccess = Color(0xFF34D399); // Success Green
  static const Color _darkBackground = Color(0xFF0F172A);
  static const Color _darkSurface = Color(0xFF1E293B);
  static const Color _darkText = Color(0xFFF8FAFC);
  static const Color _darkError = Color(0xFFEF4444);

  // --- Typography ---
  
  static TextTheme _textTheme(Color textColor) {
    return GoogleFonts.interTextTheme().apply(
      bodyColor: textColor,
      displayColor: textColor,
    );
  }

  // --- Themes ---

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _lightPrimary,
      onPrimary: Colors.white,
      secondary: _lightPrimary,
      onSecondary: Colors.white,
      error: _lightError,
      onError: Colors.white,
      surface: _lightSurface,
      onSurface: _lightText,
      surfaceContainer: _lightBackground, // Used for main backgrounds in M3
    ),
    scaffoldBackgroundColor: _lightBackground,
    textTheme: _textTheme(_lightText),
    
    // Component Themes
    cardTheme: CardThemeData(
      color: _lightSurface,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)), // Slate-200
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _darkPrimary,
      onPrimary: _darkBackground,
      secondary: _darkPrimary,
      onSecondary: _darkBackground,
      error: _darkError,
      onError: Colors.white,
      surface: _darkSurface,
      onSurface: _darkText,
      surfaceContainer: _darkBackground,
    ),
    scaffoldBackgroundColor: _darkBackground,
    textTheme: _textTheme(_darkText),

    // Component Themes
    cardTheme: CardThemeData(
      color: _darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF334155), width: 1), // Slate-700
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimary,
        foregroundColor: _darkBackground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
  
  // Custom accessors for specific design tokens if needed
  static Color get successLight => _lightSuccess;
  static Color get successDark => _darkSuccess;
}
