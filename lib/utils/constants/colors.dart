import 'package:flutter/material.dart';

class FColors {
  FColors._();
// APP basic colors
  static const Color primaryColor = Color.fromARGB(255, 29, 119, 112);
  static const Color brandColor = Color(0xFF4868FF);
  // static const Color primaryColor = Color.fromARGB(255, 235, 197, 73);
  static const Color secondaryColor = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  //gradient colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFFff9a9e),
      Color(0xFFfad0c4),
      Color(0xFFfad0c4),
    ],
  );

  //Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textColorSecondary = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

  //background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //Background container colors
  static const Color containerLight = Color(0xFFF6F6F6);
  static Color containerDark = Colors.white.withOpacity(0.1);

  //button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFB8C00);
  static const Color info = Color(0xFF2196F3);

  //neutral colors
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF828282);
  static const Color grey = Color(0xFFBDBDBD);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color lighterGrey = Color(0xFFE0E0E0);
  static const Color white = Color(0xFFFFFFFF);
}
