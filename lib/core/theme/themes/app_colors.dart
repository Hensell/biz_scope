import 'package:flutter/material.dart';

class AppColors {
  // Paleta principal
  static const deepBlack = Color(0xFF211A1D); // Fondo dark
  static const purple = Color(0xFF6320EE); // Principal (Primary)
  static const purpleLight = Color(0xFF8075FF); // Accent / Secondary
  static const lilac = Color(0xFFF8F0FB); // Fondo claro / Card
  static const mint = Color(0xFFCAD5CA); // Success/acento/focus
  static const Color white = Colors.white;

  // Textos
  static const textDark = Color(0xFF221D22); // Texto fuerte en fondo claro
  static const textMedium = Color(0xFF4C4452); // Texto secundario
  static const textLight = Color(
    0xFF8075FF,
  ); // Texto link/acento en fondo oscuro

  // Surfaces / Cards
  static const Color cardLight = lilac; // Cards en theme claro
  static const Color cardDark = deepBlack; // Cards en theme dark

  // Gradientes
  static const LinearGradient gradientPurple = LinearGradient(
    colors: [purple, purpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Estados (puedes tunearlos si querés)
  static const success = Color(0xFF53B97A);
  static const warning = Color(0xFFFFC107);
  static const danger = Color(0xFFEF5350);

  // Shadows
  static BoxShadow shadowMd = const BoxShadow(
    color: Colors.black26,
    blurRadius: 18,
    offset: Offset(0, 6),
  );

  // Opcional: para bordes deshabilitados/input desactivado
  static const borderDisabled = Color(0xFFEEEEEE);

  // Para backgrounds alternos (ejemplo, tablas, alternar filas)
  static const altBackground = Color(0xFFF3F2F7);

  // Para overlay/transparencias (ejemplo dialogs)
  static const overlay = Color(0x66000000); // 40% negro
}
