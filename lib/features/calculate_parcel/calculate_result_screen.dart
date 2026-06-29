import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/calculate_parcel/models/package_size.dart';
import 'package:fast_courier_app/features/calculate_parcel/widgets/package_size_card.dart';
import 'package:fast_courier_app/features/track_order/widgets/track_map_placeholder.dart';
import 'package:fast_courier_app/shared/widgets/primary_button.dart';

/// Calculate Result with map + suggestion — Figma 516:3951.
class CalculateResultScreen extends StatelessWidget {
  const CalculateResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: Stack(
        children: [
          const Positioned.fill(child: TrackMapPlaceholder()),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _CalculateResultAppBar(),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _ResultBottomSheet(),
          ),
        ],
      ),
    );
  }
}

class _CalculateResultAppBar extends StatelessWidget {
  const _CalculateResultAppBar();

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
            'Calculate Result',
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

class _ResultBottomSheet extends StatelessWidget {
  const _ResultBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 461,
      decoration: const BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppLayout.cardRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Suggestion',
                style: AppTextStyles.merriweatherBold(
                  fontSize: 20,
                  height: 30,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 16),
              PackageSizeCard(
                packageSize: mockSuggestedPackage,
                isSelected: false,
                onTap: () {},
                compact: true,
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Compare Price',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.push(AppRoutes.services),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Back to Home',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                backgroundColor: AppColors.black2,
                foregroundColor: AppColors.white,
                border: const BorderSide(color: AppColors.white30),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}