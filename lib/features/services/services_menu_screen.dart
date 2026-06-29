import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Services hub menu — Figma 515:4190.
class ServicesMenuScreen extends StatelessWidget {
  const ServicesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ServicesMenuAppBar(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _MenuRow(
                    label: 'Track Order',
                    icon: Icons.explore_outlined,
                    iconColor: AppColors.primary,
                    backgroundColor: AppColors.black2,
                    textColor: AppColors.white,
                    onTap: () => context.push(AppRoutes.trackOrder),
                  ),
                  const SizedBox(height: 16),
                  _MenuRow(
                    label: 'Calculate Parcel',
                    icon: Icons.add,
                    iconColor: AppColors.primary,
                    backgroundColor: AppColors.black2,
                    textColor: AppColors.white,
                    onTap: () => context.push(AppRoutes.calculateParcel),
                  ),
                  const SizedBox(height: 16),
                  _MenuRow(
                    label: 'Ship Parcel',
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppColors.black1,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black1,
                    onTap: () => context.push(AppRoutes.shipParcel),
                  ),
                  const SizedBox(height: 16),
                  _MenuRow(
                    label: 'Nearby Courier',
                    icon: Icons.location_on_outlined,
                    iconColor: AppColors.black1,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black1,
                    onTap: () => context.push(AppRoutes.nearbyCourier),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServicesMenuAppBar extends StatelessWidget {
  const _ServicesMenuAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Services',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}