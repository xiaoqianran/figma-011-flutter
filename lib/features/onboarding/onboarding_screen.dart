import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Placeholder until onboarding screens (423:1476, 423:1511, 423:1577) are built.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black1,
      body: Center(
        child: Text(
          'Onboarding',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}