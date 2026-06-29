import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Shipping ID search bar on map — Figma 516:2613.
class TrackSearchBar extends StatelessWidget {
  const TrackSearchBar({
    super.key,
    required this.controller,
    this.onSearch,
    this.hint = 'Enter shipping ID',
  });

  final TextEditingController controller;
  final VoidCallback? onSearch;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 18,
            color: AppColors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSearch?.call(),
              style: AppTextStyles.dmSans(
                fontSize: 12,
                height: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (onSearch != null)
            GestureDetector(
              onTap: onSearch,
              child: Text(
                'Track',
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}