import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  // Dynamic Color Palette
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1E88E5);
  static const Color accentLight = Color(0xFF00BFA5);
  static const Color accentDark = Color(0xFF00897B);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color successColor = Color(0xFF43A047);

  // Dynamic Text Theme Builder
  static TextTheme _buildTextTheme(TextTheme base, {double scaleFactor = 1.0}) {
    return base.copyWith(
      displayLarge: GoogleFonts.poppins(
        textStyle: base.displayLarge!.copyWith(
          fontSize: 57 * scaleFactor,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          height: 1.12,
        ),
      ),
      headlineMedium: GoogleFonts.poppins(
        textStyle: base.headlineMedium!.copyWith(
          fontSize: 28 * scaleFactor,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.29,
        ),
      ),
      bodyLarge: GoogleFonts.inter(
        textStyle: base.bodyLarge!.copyWith(
          fontSize: 16 * scaleFactor,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
      ),
      bodySmall: GoogleFonts.inter(
        textStyle: base.bodySmall!.copyWith(
          fontSize: 12 * scaleFactor,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
      ),
    );
  }

  // Light Theme
  static ThemeData lightTheme({double textScaleFactor = 1.0}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryLight,
        secondary: accentLight,
        error: errorColor,
        background: Colors.grey.shade50,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onBackground: Colors.black87,
        onSurface: Colors.black87,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20 * textScaleFactor,
            letterSpacing: 0.15,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87, size: 24),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryLight, width: 2),
        ),
      ),
    ).copyWith(
      textTheme: _buildTextTheme(ThemeData.light().textTheme,
          scaleFactor: textScaleFactor),
    );
  }

  // Dark Theme
  static ThemeData darkTheme({double textScaleFactor = 1.0}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: primaryDark,
        secondary: accentDark,
        error: errorColor,
        background: const Color(0xFF121212),
        surface: const Color(0xFF1E1E1E),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20 * textScaleFactor,
            letterSpacing: 0.15,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryDark, width: 2),
        ),
      ),
    ).copyWith(
      textTheme: _buildTextTheme(ThemeData.dark().textTheme,
          scaleFactor: textScaleFactor),
    );
  }
}
