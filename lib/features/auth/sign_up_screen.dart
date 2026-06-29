import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Placeholder until Figma 515:1731 Sign up screen is built.
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black1,
      body: Center(
        child: Text(
          'Sign up',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}