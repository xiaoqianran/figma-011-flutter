import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/core/utils/form_validators.dart';
import 'package:figma_011/shared/widgets/app_logo.dart';
import 'package:figma_011/shared/widgets/auth_divider.dart';
import 'package:figma_011/shared/widgets/auth_text_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';
import 'package:figma_011/shared/widgets/remember_me_checkbox.dart';
import 'package:figma_011/shared/widgets/social_login_button.dart';

/// Sign up screen — Figma node 515:1731 (frame name: Sing up).
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Ferdous Sarker');
  final TextEditingController _phoneController =
      TextEditingController(text: '+880-51248 984');
  final TextEditingController _emailController =
      TextEditingController(text: 'ferdous@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'password');
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _signUp() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    AppState.instance.rememberMe = _rememberMe;
    final ok = AppState.instance.signUp(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
    if (!ok) {
      showAppSnackBar(
        context,
        message: 'Sign up failed. Check your details.',
        isError: true,
      );
      return;
    }
    context.go(AppRoutes.home);
  }

  void _socialLogin(SocialProvider provider) {
    final label = switch (provider) {
      SocialProvider.google => 'Google',
      SocialProvider.facebook => 'Facebook',
      SocialProvider.twitter => 'Twitter',
      SocialProvider.apple => 'Apple',
    };
    final email = '${provider.name}@demo.com';
    AppState.instance.rememberMe = _rememberMe;
    AppState.instance.login(email: email, password: 'password');
    showAppSnackBar(context, message: 'Signed in with $label');
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const AppLogo(width: 96, height: 50),
                const SizedBox(height: 40),
                Text(
                  'Welcome to Fast!',
                  style: AppTextStyles.merriweatherBold(
                    fontSize: 30,
                    height: 38,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Let\u2019s Create Account',
                  style: AppTextStyles.dmSans(
                    fontSize: 16,
                    height: 26,
                    color: AppColors.white60,
                  ),
                ),
                const SizedBox(height: 40),
                AuthTextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: (value) =>
                      FormValidators.requiredField(value, 'Name'),
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.email,
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  showVisibilityToggle: true,
                  onToggleVisibility: _togglePasswordVisibility,
                  validator: FormValidators.password,
                ),
                const SizedBox(height: 16),
                RememberMeCheckbox(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Sing up',
                  width: double.infinity,
                  height: 56,
                  borderRadius: AppLayout.buttonRadiusLg,
                  onPressed: _signUp,
                ),
                const SizedBox(height: 40),
                const AuthDivider(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      provider: SocialProvider.google,
                      onPressed: () => _socialLogin(SocialProvider.google),
                    ),
                    const SizedBox(width: 15),
                    SocialLoginButton(
                      provider: SocialProvider.facebook,
                      onPressed: () => _socialLogin(SocialProvider.facebook),
                    ),
                    const SizedBox(width: 15),
                    SocialLoginButton(
                      provider: SocialProvider.twitter,
                      onPressed: () => _socialLogin(SocialProvider.twitter),
                    ),
                    const SizedBox(width: 15),
                    SocialLoginButton(
                      provider: SocialProvider.apple,
                      onPressed: () => _socialLogin(SocialProvider.apple),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Center(child: _buildLoginPrompt(context)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.dmSans(
          fontSize: 14,
          height: 24,
          color: AppColors.white60,
        ),
        children: [
          const TextSpan(text: 'Have Account? '),
          TextSpan(
            text: 'Log In',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(AppRoutes.login),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}