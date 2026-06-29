import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/shared/widgets/app_logo.dart';
import 'package:fast_courier_app/shared/widgets/primary_button.dart';

/// Final onboarding screen — Figma 423:1577.
class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 72),
          const AppLogo(width: 91, height: 58),
          const SizedBox(height: 40),
          Text(
            'Start journey with Fast',
            textAlign: TextAlign.center,
            style: AppTextStyles.merriweatherBold(
              fontSize: 40,
              height: 46,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Log in',
            width: double.infinity,
            height: 56,
            borderRadius: AppLayout.buttonRadiusLg,
            onPressed: () => context.go(AppRoutes.login),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Sign up',
            width: double.infinity,
            height: 56,
            borderRadius: AppLayout.buttonRadiusLg,
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.white,
            border: const BorderSide(color: AppColors.white30),
            onPressed: () => context.go(AppRoutes.signUp),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}