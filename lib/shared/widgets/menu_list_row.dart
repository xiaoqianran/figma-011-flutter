import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Settings-style menu row — Figma 516:5468.
class MenuListRow extends StatelessWidget {
  const MenuListRow({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.labelColor = AppColors.white,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.white60,
            ),
          ],
        ),
      ),
    );
  }
}