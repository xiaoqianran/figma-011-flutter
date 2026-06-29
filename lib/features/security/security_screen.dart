import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/auth_text_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';
import 'package:figma_011/shared/widgets/settings_toggle_row.dart';

/// Account security settings — Menu Security item.
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _biometricEnabled = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SecurityAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  Text(
                    'Change Password',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    label: 'Current',
                    controller: _currentPasswordController,
                    obscureText: _obscureCurrent,
                    showVisibilityToggle: true,
                    onToggleVisibility: () {
                      setState(() => _obscureCurrent = !_obscureCurrent);
                    },
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    label: 'New',
                    controller: _newPasswordController,
                    obscureText: _obscureNew,
                    showVisibilityToggle: true,
                    onToggleVisibility: () {
                      setState(() => _obscureNew = !_obscureNew);
                    },
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    label: 'Confirm',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    showVisibilityToggle: true,
                    onToggleVisibility: () {
                      setState(() => _obscureConfirm = !_obscureConfirm);
                    },
                  ),
                  const SizedBox(height: 32),
                  const Divider(color: AppColors.white30),
                  SettingsToggleRow(
                    label: 'Biometric Login',
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() => _biometricEnabled = value);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Save Changes',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityAppBar extends StatelessWidget {
  const _SecurityAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Security',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}