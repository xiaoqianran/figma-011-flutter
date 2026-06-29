import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/calculate_parcel/widgets/route_selector.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Ship Parcel packaging step — Figma 516:4180.
class ShipParcelScreen extends StatelessWidget {
  const ShipParcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ShipParcelAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  const RouteSelector(
                    from: 'Gouripur, Daudkandi',
                    to: 'Tejgaon, Dhaka',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Packaging',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _PackagingTypeChip(label: 'Box'),
                  const SizedBox(height: 16),
                  const _PackageCountField(),
                  const SizedBox(height: 16),
                  const _WeightField(),
                  const SizedBox(height: 24),
                  const _InfoRow(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: PrimaryButton(
                label: 'Add Package',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                backgroundColor: AppColors.black1,
                foregroundColor: AppColors.white,
                border: const BorderSide(color: AppColors.white30),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Next',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.push(AppRoutes.shipParcelDetails),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipParcelAppBar extends StatelessWidget {
  const _ShipParcelAppBar();

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
            'Ship Parcel',
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

class _PackagingTypeChip extends StatelessWidget {
  const _PackagingTypeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.dmSans(
          fontSize: 16,
          height: 26,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _PackageCountField extends StatelessWidget {
  const _PackageCountField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '# Of Packages',
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.black2,
            borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
          ),
          child: Row(
            children: [
              Text(
                '3',
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                'Max 10',
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeightField extends StatelessWidget {
  const _WeightField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight Per Package',
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.black2,
            borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
          ),
          child: Row(
            children: [
              Text(
                '5 kg',
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                'Max Weight 10 kg',
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Calculate shipping cost base on order\n'
            'value or size of item',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}