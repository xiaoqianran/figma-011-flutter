import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Search + filter row — Figma 516:3230 / 516:3234.
class ServicesSearchBar extends StatelessWidget {
  const ServicesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.black2,
              borderRadius: BorderRadius.circular(AppLayout.cardRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Search address',
                    style: AppTextStyles.dmSans(
                      fontSize: 12,
                      height: 22,
                      color: AppColors.white60,
                    ),
                  ),
                ),
                const Icon(
                  Icons.mic_none,
                  size: 24,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          ),
          child: const Icon(
            Icons.tune,
            size: 24,
            color: AppColors.black1,
          ),
        ),
      ],
    );
  }
}