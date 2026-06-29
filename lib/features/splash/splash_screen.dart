import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/shared/widgets/app_logo.dart';

/// Splash screen — Figma node 515:1416.
///
/// Dark background (#141312) with centered brand logo (144×92).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Duration displayDuration = Duration(seconds: 2);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.black1,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    _timer = Timer(SplashScreen.displayDuration, _navigateNext);
  }

  void _navigateNext() {
    if (!mounted) {
      return;
    }
    final appState = AppState.instance;
    if (!appState.onboardingCompleted) {
      context.go(AppRoutes.onboarding);
    } else if (appState.isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}