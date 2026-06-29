import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/core/utils/form_validators.dart';
import 'package:figma_011/shared/widgets/auth_text_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Forgot password — email reset flow.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    showAppSnackBar(
      context,
      message: 'Reset link sent to ${_emailController.text.trim()}',
    );
    context.pop();
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
                const SizedBox(height: 16),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  'Forgot Password?',
                  style: AppTextStyles.merriweatherBold(
                    fontSize: 30,
                    height: 38,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter your email and we will send a reset link.',
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
                  validator: FormValidators.email,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Send Reset Link',
                  width: double.infinity,
                  height: 56,
                  borderRadius: AppLayout.buttonRadiusLg,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}