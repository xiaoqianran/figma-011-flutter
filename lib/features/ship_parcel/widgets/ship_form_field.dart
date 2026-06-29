import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';

/// Single-line or multiline form field — Figma 516:4290.
class ShipFormField extends StatelessWidget {
  const ShipFormField({
    super.key,
    required this.placeholder,
    this.height = 56,
    this.trailing,
    this.value,
    this.onTap,
  });

  final String placeholder;
  final double height;
  final Widget? trailing;
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value ?? placeholder,
              style: value == null
                  ? AppTextStyles.dmSans(
                      fontSize: 16,
                      height: 26,
                      color: AppColors.white60,
                    )
                  : AppTextStyles.dmSans(
                      fontSize: 16,
                      height: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
            ),
          ),
          ?trailing,
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(
      onTap: onTap,
      child: content,
    );
  }
}