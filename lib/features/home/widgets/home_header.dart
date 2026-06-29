import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Greeting row with avatar and search icon — Figma 515:2596.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.userName = 'Ferdous',
    this.onSearchTap,
  });

  final String userName;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary20, width: 2),
            color: AppColors.black2,
          ),
          child: Icon(
            Icons.person_outline,
            color: AppColors.white60,
            size: 28,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello $userName,',
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: AppColors.white60,
                ),
              ),
              Text(
                'Welcome Back!',
                style: AppTextStyles.merriweatherBold(
                  fontSize: 20,
                  height: 30,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSearchTap,
          icon: const Icon(
            Icons.search,
            color: AppColors.white,
            size: 24,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
        ),
      ],
    );
  }
}