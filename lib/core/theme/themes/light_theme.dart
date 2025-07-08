import 'package:biz_scope/core/theme/extensions/text_styles.dart';
import 'package:biz_scope/core/theme/themes/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: AppColors.purple,
  scaffoldBackgroundColor: AppColors.lilac,
  colorScheme: const ColorScheme.light(
    primary: AppColors.purple,
    secondary: AppColors.mint,
    surface: AppColors.cardLight,
    onSecondary: AppColors.deepBlack,
    onSurface: AppColors.deepBlack,
    error: AppColors.danger,
  ),
  textTheme: AppTextStyles.textTheme.copyWith(
    bodyLarge: const TextStyle(
      color: AppColors.deepBlack,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(color: AppColors.purpleLight),
    titleLarge: const TextStyle(
      color: AppColors.purple,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: const TextStyle(
      color: AppColors.purple,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    labelLarge: const TextStyle(
      color: AppColors.mint,
      fontWeight: FontWeight.w600,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lilac,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.purple),
    titleTextStyle: TextStyle(
      color: AppColors.purple,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 0.5,
    ),
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    color: AppColors.cardLight,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: Colors.black12,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple,
    foregroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      backgroundColor: AppColors.cardLight,
      selectedBackgroundColor: AppColors.purple.withValues(alpha: 0.13),
      foregroundColor: AppColors.purple,
      selectedForegroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.lilac.withValues(alpha: 0.9),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.purpleLight, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.purple, width: 2),
    ),
    labelStyle: const TextStyle(color: AppColors.purple),
    hintStyle: const TextStyle(color: AppColors.textMedium),
  ),
  iconTheme: const IconThemeData(color: AppColors.purple),
);
