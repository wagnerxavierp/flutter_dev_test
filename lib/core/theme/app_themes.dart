import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_colors.dart';

class AppThemes {
  static TextTheme get _baseTextTheme => GoogleFonts.plusJakartaSansTextTheme();

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        colorScheme: ColorScheme.light(
          primary: MyColors.light.primary,
          secondary: MyColors.light.secondary,
          background: MyColors.light.background,
          surface: MyColors.light.surface,
          error: MyColors.light.error,
        ),
        textTheme: _baseTextTheme.copyWith(
          bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
            color: MyColors.light.textPrimary,
          ),
          labelMedium: _baseTextTheme.labelMedium?.copyWith(
            color: MyColors.light.textPrimary,
          ),
          labelLarge: _baseTextTheme.labelLarge?.copyWith(
            color: MyColors.light.textPrimary,
          ),
          titleLarge: _baseTextTheme.titleLarge?.copyWith(
            color: MyColors.light.textPrimary,
          ),
        ),
        primaryTextTheme: _baseTextTheme.copyWith(
          bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
            color: MyColors.light.textPrimary,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: MyColors.light.textPrimary,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: MyColors.light.primary,
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 248, 248, 250),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      );

  // TODO: Implementar darkTheme
}
