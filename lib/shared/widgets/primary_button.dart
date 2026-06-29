import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.borderRadius = AppLayout.buttonRadiusSm,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.black1,
    this.border,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: border == null ? null : Border.fromBorderSide(border!),
            ),
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 14,
                  height: 24,
                  color: foregroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}