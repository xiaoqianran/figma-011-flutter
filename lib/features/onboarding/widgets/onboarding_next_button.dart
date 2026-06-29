import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';

/// Red vertical pill with forward arrow — Figma Arrow/Next (80×160).
class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        bottomLeft: Radius.circular(40),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        child: const SizedBox(
          width: 80,
          height: 160,
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}