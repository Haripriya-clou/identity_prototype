import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Modern Color Palette
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFFEEF2FF); // Indigo 50
  
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryLight = Color(0xFFD1FAE5); 
  
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color error = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFF59E0B); // Amber
  
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color surfaceLight = Color(0xFFF3F4F6);
  
  static const Color text = Color(0xFF111827); // Gray 900
  static const Color textSecondary = Color(0xFF6B7280); // Gray 500
  static const Color border = Color(0xFFE5E7EB); // Gray 200

  // 🌈 Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunset = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 📱 Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        tertiary: accent,
        surface: surface,
        error: error,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      
      // AppBar Styling
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle( 
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Text Themes
      textTheme: TextTheme(
        // Display Large
        displayLarge: TextStyle( 
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: text,
        ),
        // Display Medium
        displayMedium: TextStyle( 
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: text,
        ),
        // Headline Large
        headlineLarge: TextStyle( 
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        // Headline Medium
        headlineMedium: TextStyle( 
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        // Title Large
        titleLarge: TextStyle( 
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        // Body Large
        bodyLarge: TextStyle( 
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: text,
        ),
        // Body Medium
        bodyMedium: TextStyle( 
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        // Body Small
        bodySmall: TextStyle( 
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        // Label Large
        labelLarge: TextStyle( 
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Button Themes
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle( 
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle( 
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        shadowColor: primary.withOpacity(0.1),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        labelStyle: TextStyle( 
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        hintStyle: TextStyle( 
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),

      // Dropdown
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: primaryLight,
        labelStyle: TextStyle( 
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // FAB Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
