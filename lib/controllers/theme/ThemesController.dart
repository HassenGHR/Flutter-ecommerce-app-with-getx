import 'dart:ui';

import 'package:day59/views/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom color schemes for the e-commerce app
class AppColors {
  // Using ColorScheme.fromSeed for better color harmony
  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF4CAF50),
    brightness: Brightness.light,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF66BB6A),
    brightness: Brightness.dark,
  );

  // E-commerce specific colors derived from the schemes
  static Color saleLight = lightScheme.error;
  static Color newTagLight = lightScheme.tertiary;
  static Color ratingStarLight = const Color(0xFFFFB300);
  static Color wishlistLight = lightScheme.secondary;
  static final Color discountBadgeLight = lightScheme.error.withOpacity(0.9);

  // Dark theme variations
  static Color saleDark = darkScheme.error;
  static Color newTagDark = darkScheme.tertiary;
  static Color ratingStarDark = const Color(0xFFFFD740);
  static Color wishlistDark = darkScheme.secondary;
  static final Color discountBadgeDark = darkScheme.error.withOpacity(0.9);
}

class AppTextStyles {
  static const double _scaleFactor = 1.0;

  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
        fontSize: 32 * _scaleFactor,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
        fontSize: 28 * _scaleFactor,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
        fontSize: 22 * _scaleFactor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMedium => GoogleFonts.plusJakartaSans(
        fontSize: 18 * _scaleFactor,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(
        fontSize: 16 * _scaleFactor,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
      fontSize: 14 * _scaleFactor,
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle get priceText => GoogleFonts.plusJakartaSans(
        fontSize: 20 * _scaleFactor,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get discountText => GoogleFonts.plusJakartaSans(
        fontSize: 16 * _scaleFactor,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.lineThrough,
      );

  static TextStyle get productTitle => GoogleFonts.plusJakartaSans(
        fontSize: 16 * _scaleFactor,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get categoryTitle => GoogleFonts.plusJakartaSans(
        fontSize: 20 * _scaleFactor,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      );

  static TextStyle get salePrice => GoogleFonts.plusJakartaSans(
        fontSize: 18 * _scaleFactor,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get reviewCount => GoogleFonts.plusJakartaSans(
        fontSize: 12 * _scaleFactor,
        color: Colors.grey,
      );

  static TextStyle get stockStatus => GoogleFonts.plusJakartaSans(
        fontSize: 13 * _scaleFactor,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get priceLarge => GoogleFonts.plusJakartaSans(
        fontSize: 24 * _scaleFactor,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      );

  static TextStyle get priceSmall => GoogleFonts.plusJakartaSans(
        fontSize: 16 * _scaleFactor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get badge => GoogleFonts.plusJakartaSans(
        fontSize: 12 * _scaleFactor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonText => GoogleFonts.plusJakartaSans(
        fontSize: 16 * _scaleFactor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );
}

class ThemesController extends GetxController {
  final storage = GetStorage();
  var theme = 'light'.obs;
  Function(String)? onThemeChanged;

  @override
  void onInit() {
    super.onInit();
    getThemeState();
  }

  getThemeState() {
    if (storage.read('theme') != null) {
      return setTheme(storage.read('theme'));
    }
    setTheme('light');
  }

  void setTheme(String value) {
    theme.value = value;
    storage.write('theme', value);

    if (value == 'light') Get.changeThemeMode(ThemeMode.light);
    if (value == 'dark') Get.changeThemeMode(ThemeMode.dark);

    onThemeChanged?.call(value);

    update();
  }

  // Enhanced light theme for e-commerce
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.lightScheme,
        scaffoldBackgroundColor: AppColors.lightScheme.background,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightScheme.surface,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.lightScheme.onSurface),
          titleTextStyle: GoogleFonts.plusJakartaSans(
            color: AppColors.lightScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shadowColor: AppColors.lightScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(4),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.lightScheme.surfaceVariant,
          selectedColor: AppColors.lightScheme.primary,
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightScheme.primary,
            foregroundColor: AppColors.lightScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            shadowColor: AppColors.lightScheme.shadow,
          ).copyWith(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) return 4;
                if (states.contains(MaterialState.focused)) return 2;
                if (states.contains(MaterialState.pressed)) return 1;
                return 2;
              },
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightScheme.surfaceVariant.withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.lightScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.lightScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.lightScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.lightScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.lightScheme.error,
              width: 2,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.lightScheme.surface,
          selectedItemColor: AppColors.lightScheme.primary,
          unselectedItemColor: AppColors.lightScheme.onSurfaceVariant,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        extensions: [
          ProductCardTheme(
            saleTagColor: AppColors.saleLight,
            newTagColor: AppColors.newTagLight,
            ratingStarColor: AppColors.ratingStarLight,
            wishlistColor: AppColors.wishlistLight,
            inStockColor: AppColors.lightScheme.primary,
            outOfStockColor: AppColors.lightScheme.error,
            discountBadgeColor: AppColors.discountBadgeLight,
            cardElevation: 3.0,
            cardPadding: const EdgeInsets.all(16),
          ),
        ],
      );
  // Enhanced dark theme for e-commerce
  ThemeData get darkTheme => ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: AppColors.darkScheme,
        scaffoldBackgroundColor: AppColors.darkScheme.background,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkScheme.surface,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.darkScheme.onSurface),
          titleTextStyle: GoogleFonts.plusJakartaSans(
            color: AppColors.darkScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shadowColor: AppColors.darkScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(4),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.darkScheme.surfaceVariant,
          selectedColor: AppColors.darkScheme.primary,
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkScheme.primary,
            foregroundColor: AppColors.darkScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            shadowColor: AppColors.darkScheme.shadow,
          ).copyWith(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) return 4;
                if (states.contains(MaterialState.focused)) return 2;
                if (states.contains(MaterialState.pressed)) return 1;
                return 2;
              },
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkScheme.surfaceVariant.withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.darkScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.darkScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.darkScheme.error,
              width: 2,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkScheme.surface,
          selectedItemColor: AppColors.darkScheme.primary,
          unselectedItemColor: AppColors.darkScheme.onSurfaceVariant,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        extensions: [
          ProductCardTheme(
            saleTagColor: AppColors.saleLight,
            newTagColor: AppColors.newTagLight,
            ratingStarColor: AppColors.ratingStarLight,
            wishlistColor: AppColors.wishlistLight,
            inStockColor: AppColors.darkScheme.primary,
            outOfStockColor: AppColors.darkScheme.error,
            discountBadgeColor: AppColors.discountBadgeLight,
            cardElevation: 3.0,
            cardPadding: const EdgeInsets.all(16),
          ),
        ],
      );
}

// Custom theme extension for product cards
class ProductCardTheme extends ThemeExtension<ProductCardTheme> {
  final Color saleTagColor;
  final Color newTagColor;
  final Color ratingStarColor;
  final Color wishlistColor;
  final Color inStockColor;
  final Color outOfStockColor;
  final Color discountBadgeColor; // Added property
  final double cardElevation; // Added property
  final EdgeInsets cardPadding; // Added property

  ProductCardTheme({
    required this.saleTagColor,
    required this.newTagColor,
    required this.ratingStarColor,
    required this.wishlistColor,
    required this.inStockColor,
    required this.outOfStockColor,
    required this.discountBadgeColor,
    this.cardElevation = 2.0,
    this.cardPadding = const EdgeInsets.all(12),
  });

  @override
  ThemeExtension<ProductCardTheme> copyWith({
    Color? saleTagColor,
    Color? newTagColor,
    Color? ratingStarColor,
    Color? wishlistColor,
    Color? inStockColor,
    Color? outOfStockColor,
    Color? discountBadgeColor,
    double? cardElevation,
    EdgeInsets? cardPadding,
  }) {
    return ProductCardTheme(
      saleTagColor: saleTagColor ?? this.saleTagColor,
      newTagColor: newTagColor ?? this.newTagColor,
      ratingStarColor: ratingStarColor ?? this.ratingStarColor,
      wishlistColor: wishlistColor ?? this.wishlistColor,
      inStockColor: inStockColor ?? this.inStockColor,
      outOfStockColor: outOfStockColor ?? this.outOfStockColor,
      discountBadgeColor: discountBadgeColor ?? this.discountBadgeColor,
      cardElevation: cardElevation ?? this.cardElevation,
      cardPadding: cardPadding ?? this.cardPadding,
    );
  }

  @override
  ThemeExtension<ProductCardTheme> lerp(
    ThemeExtension<ProductCardTheme>? other,
    double t,
  ) {
    if (other is! ProductCardTheme) {
      return this;
    }
    return ProductCardTheme(
      saleTagColor: Color.lerp(saleTagColor, other.saleTagColor, t)!,
      newTagColor: Color.lerp(newTagColor, other.newTagColor, t)!,
      ratingStarColor: Color.lerp(ratingStarColor, other.ratingStarColor, t)!,
      wishlistColor: Color.lerp(wishlistColor, other.wishlistColor, t)!,
      inStockColor: Color.lerp(inStockColor, other.inStockColor, t)!,
      outOfStockColor: Color.lerp(outOfStockColor, other.outOfStockColor, t)!,
      discountBadgeColor:
          Color.lerp(discountBadgeColor, other.discountBadgeColor, t)!,
      cardElevation: lerpDouble(cardElevation, other.cardElevation, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
    );
  }
}
