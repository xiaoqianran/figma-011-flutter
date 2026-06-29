import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/onboarding/widgets/onboarding_content_page.dart';
import 'package:figma_011/features/onboarding/widgets/onboarding_welcome_page.dart';

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

  void _completeOnboarding() {
    AppState.instance.completeOnboarding();
  }

  void _skip() {
    _completeOnboarding();
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              children: [
                OnboardingContentPage(
                  title: 'We deliver\nall around\nthe world',
                  currentStep: 1,
                  totalSteps: _totalSteps,
                  illustrationAsset:
                      'assets/images/onboarding_illustration_1.png',
                  progressTrackWidth: 100,
                  onNext: () => _goToPage(1),
                  onGetStarted: _goToWelcome,
                ),
                OnboardingContentPage(
                  title: 'Find your product very easily',
                  currentStep: 2,
                  totalSteps: _totalSteps,
                  illustrationAsset:
                      'assets/images/onboarding_illustration_2.png',
                  progressTrackWidth: 95.59,
                  onNext: _goToWelcome,
                  onGetStarted: _goToWelcome,
                ),
                OnboardingWelcomePage(onComplete: _completeOnboarding),
              ],
            ),
            Positioned(
              top: 8,
              right: 16,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  'Skip',
                  style: AppTextStyles.dmSans(
                    fontSize: 14,
                    height: 24,
                    color: AppColors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}