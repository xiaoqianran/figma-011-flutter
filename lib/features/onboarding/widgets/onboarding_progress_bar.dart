import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.trackWidth = 100,
  });

  final int currentStep;
  final int totalSteps;
  final double trackWidth;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$currentStep/$totalSteps',
          style: AppTextStyles.merriweatherRegular(
            fontSize: 36,
            height: 36,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: trackWidth,
          height: 2,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white30,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: const SizedBox.expand(),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0, 1),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}