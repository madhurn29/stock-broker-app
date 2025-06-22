import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF3F51B5); // Indigo
  static const Color secondary = Color(0xFF009688); // Teal
  static const Color background = Color(0xFFF5F5F5); // Light gray
  static const Color textPrimary = Color(0xff1E1E1E);
  static const Color textSecondary = Color(0xFF757575);

  static const Color buyGreen = Color(0xFF4CAF50);
  static const Color sellRed = Color(0xFFF44336);
}

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
    accentColor: AppColors.secondary,
    backgroundColor: AppColors.background,
  ).copyWith(secondary: AppColors.secondary),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColors.textPrimary, fontSize: 22),
    titleMedium: TextStyle(color: AppColors.textPrimary, fontSize: 20),
    titleSmall: TextStyle(color: AppColors.textPrimary, fontSize: 18),
    bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);


// https://github.com/madhurn29/stock-broker-app.git