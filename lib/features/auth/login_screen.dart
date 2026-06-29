import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Placeholder until Figma 515:1647 Log In screen is built.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black1,
      body: Center(
        child: Text(
          'Log In',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}