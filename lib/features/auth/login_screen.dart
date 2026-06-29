import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/app_logo.dart';
import 'package:figma_011/shared/widgets/auth_divider.dart';
import 'package:figma_011/shared/widgets/auth_text_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';
import 'package:figma_011/shared/widgets/social_login_button.dart';

/// Log In screen — Figma node 515:1647.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: 'ferdous@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'password');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              const AppLogo(width: 96, height: 50),
              const SizedBox(height: 36),
              Text(
                'Welcome Back!',
                style: AppTextStyles.merriweatherBold(
                  fontSize: 30,
                  height: 38,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Let\u2019s Get Start',
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white60,
                ),
              ),
              const SizedBox(height: 40),
              AuthTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              AuthTextField(
                label: 'Password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                showVisibilityToggle: true,
                onToggleVisibility: _togglePasswordVisibility,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forget Password?',
                    style: AppTextStyles.dmSans(
                      fontSize: 14,
                      height: 24,
                      color: AppColors.black50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Log in',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.go(AppRoutes.home),
              ),
              const SizedBox(height: 40),
              const AuthDivider(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(provider: SocialProvider.google),
                  const SizedBox(width: 15),
                  SocialLoginButton(provider: SocialProvider.facebook),
                  const SizedBox(width: 15),
                  SocialLoginButton(provider: SocialProvider.twitter),
                  const SizedBox(width: 15),
                  SocialLoginButton(provider: SocialProvider.apple),
                ],
              ),
              const SizedBox(height: 48),
              Center(child: _buildSignUpPrompt(context)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.dmSans(
          fontSize: 14,
          height: 24,
          color: AppColors.white60,
        ),
        children: [
          const TextSpan(text: 'New User? '),
          TextSpan(
            text: 'Create Account',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(AppRoutes.signUp),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}