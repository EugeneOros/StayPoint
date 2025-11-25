import 'package:flutter/material.dart';
import 'colors.dart';
import 'dimens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.backgroundBrand,
        secondary: AppColors.interactionPrimary,
        error: AppColors.red,
        surface: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.xm),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.backgroundBrand,
        unselectedItemColor: AppColors.contentSecondary,
      ),
    );
  }
}
