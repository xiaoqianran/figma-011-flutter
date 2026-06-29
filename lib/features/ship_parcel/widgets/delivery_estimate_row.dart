import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/app_logo.dart';

/// Arrives on / Delivered by row — Figma 516:4312.
class DeliveryEstimateRow extends StatelessWidget {
  const DeliveryEstimateRow({
    super.key,
    this.arrivesOn = 'Wed, Oct 16',
    this.deliveredBy = '5.00 pm',
  });

  final String arrivesOn;
  final String deliveredBy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                arrivesOn,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Arives On',
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: AppColors.white60,
                ),
              ),
            ],
          ),
        ),
        const AppLogo(width: 24, height: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                deliveredBy,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Delivered By',
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
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