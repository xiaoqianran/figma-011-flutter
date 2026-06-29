import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/onboarding/widgets/onboarding_next_button.dart';
import 'package:figma_011/features/onboarding/widgets/onboarding_progress_bar.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Onboarding slide with illustration, progress, title, and actions.
class OnboardingContentPage extends StatelessWidget {
  const OnboardingContentPage({
    super.key,
    required this.title,
    required this.currentStep,
    required this.totalSteps,
    required this.illustrationAsset,
    required this.onNext,
    required this.onGetStarted,
    this.progressTrackWidth = 100,
  });

  final String title;
  final int currentStep;
  final int totalSteps;
  final String illustrationAsset;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;
  final double progressTrackWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Center(
                child: Image.asset(
                  illustrationAsset,
                  width: 297,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const Spacer(),
              OnboardingProgressBar(
                currentStep: currentStep,
                totalSteps: totalSteps,
                trackWidth: progressTrackWidth,
              ),
              const SizedBox(height: 40),
              Text(
                title,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 40,
                  height: 46,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Get Started',
                width: 130,
                onPressed: onGetStarted,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 140,
          child: OnboardingNextButton(onPressed: onNext),
        ),
      ],
    );
  }
}