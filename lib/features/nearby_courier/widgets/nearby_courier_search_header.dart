import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Back + search row — Figma 516:2362 / 516:2365.
class NearbyCourierSearchHeader extends StatelessWidget {
  const NearbyCourierSearchHeader({
    super.key,
    required this.onBack,
    this.searchController,
    this.onSearchChanged,
  });

  final VoidCallback onBack;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        children: [
          _BackButton(onPressed: onBack),
          const SizedBox(width: 16),
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
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      style: AppTextStyles.dmSans(
                        fontSize: 12,
                        height: 22,
                        color: AppColors.white,
                      ),
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        hintText: 'Search address',
                        hintStyle: AppTextStyles.dmSans(
                          fontSize: 12,
                          height: 22,
                          color: AppColors.white50,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
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
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 24,
          color: AppColors.black1,
        ),
      ),
    );
  }
}