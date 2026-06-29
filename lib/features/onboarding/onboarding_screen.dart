import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/features/onboarding/widgets/onboarding_content_page.dart';
import 'package:fast_courier_app/features/onboarding/widgets/onboarding_welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  static const int _contentPageCount = 2;
  static const int _totalSteps = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToWelcome() => _goToPage(_contentPageCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          children: [
            OnboardingContentPage(
              title: 'We deliver\nall around\nthe world',
              currentStep: 1,
              totalSteps: _totalSteps,
              illustrationAsset: 'assets/images/onboarding_illustration_1.png',
              progressTrackWidth: 100,
              onNext: () => _goToPage(1),
              onGetStarted: _goToWelcome,
            ),
            OnboardingContentPage(
              title: 'Find your product very easily',
              currentStep: 2,
              totalSteps: _totalSteps,
              illustrationAsset: 'assets/images/onboarding_illustration_2.png',
              progressTrackWidth: 95.59,
              onNext: _goToWelcome,
              onGetStarted: _goToWelcome,
            ),
            const OnboardingWelcomePage(),
          ],
        ),
      ),
    );
  }
}