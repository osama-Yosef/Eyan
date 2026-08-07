import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const String _font = 'Inter';
  static const TextStyle displayLarge = TextStyle(fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.2);
  static const TextStyle displayMedium = TextStyle(fontFamily: _font, fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.25);
  static const TextStyle headingLarge = TextStyle(fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle headingMedium = TextStyle(fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4);
  static const TextStyle headingSmall = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4);
  static const TextStyle bodyLarge = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary, height: 1.5);
  static const TextStyle bodyMedium = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle bodySmall = TextStyle(fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle labelLarge = TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.surface, height: 1.2);
  static const TextStyle labelMedium = TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 1.2);
}
