import 'package:biz_scope/core/theme/extensions/text_styles.dart';
import 'package:biz_scope/core/theme/themes/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: AppColors.purple,
  scaffoldBackgroundColor: AppColors.deepBlack,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.purple,
    secondary: AppColors.mint,
    surface: AppColors.cardDark,
    onPrimary: AppColors.lilac,
    onSecondary: AppColors.deepBlack,
    onSurface: AppColors.lilac,
    error: AppColors.danger,
    onError: AppColors.lilac,
  ),
  textTheme: AppTextStyles.textTheme.copyWith(
    bodyLarge: const TextStyle(
      color: AppColors.lilac,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(color: AppColors.mint),
    titleLarge: const TextStyle(
      color: AppColors.purpleLight,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: const TextStyle(
      color: AppColors.lilac,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    labelLarge: const TextStyle(
      color: AppColors.purpleLight,
      fontWeight: FontWeight.w600,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.deepBlack,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.lilac),
    titleTextStyle: TextStyle(
      color: AppColors.purpleLight,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 0.5,
    ),
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    color: AppColors.cardDark,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: Colors.black54,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple,
    foregroundColor: AppColors.lilac,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      backgroundColor: AppColors.deepBlack,
      selectedBackgroundColor: AppColors.purpleLight.withValues(alpha: 0.17),
      foregroundColor: AppColors.lilac,
      selectedForegroundColor: AppColors.deepBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.cardDark.withValues(alpha: 0.9),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.purpleLight, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.purple, width: 2),
    ),
    labelStyle: const TextStyle(color: AppColors.purpleLight),
    hintStyle: const TextStyle(color: AppColors.mint),
  ),
  iconTheme: const IconThemeData(color: AppColors.purpleLight),
);
