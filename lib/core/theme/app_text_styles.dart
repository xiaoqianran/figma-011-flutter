import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Typography mapped from Figma Font Style collection.
abstract final class AppTextStyles {
  static TextStyle merriweatherBlack({
    required double fontSize,
    required double height,
    Color color = AppColors.black1,
  }) {
    return GoogleFonts.merriweather(
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      height: height / fontSize,
      color: color,
    );
  }

  static TextStyle merriweatherBold({
    required double fontSize,
    required double height,
    Color color = AppColors.white,
  }) {
    return GoogleFonts.merriweather(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      height: height / fontSize,
      color: color,
    );
  }

  static TextStyle merriweatherRegular({
    required double fontSize,
    required double height,
    Color color = AppColors.primary,
  }) {
    return GoogleFonts.merriweather(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: height / fontSize,
      color: color,
    );
  }

  static TextStyle dmSans({
    required double fontSize,
    required double height,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.white,
  }) {
    return GoogleFonts.dmSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height / fontSize,
      color: color,
    );
  }
}