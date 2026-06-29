import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/core/utils/form_validators.dart';
import 'package:figma_011/shared/widgets/auth_text_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// My Profile edit screen — Figma 516:5624.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = AppState.instance;
    _nameController.text = state.userName;
    _phoneController.text = state.userPhone;
    _emailController.text = state.userEmail;
    _addressController.text = state.userAddress;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    AppState.instance.updateProfile(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
    );
    showAppSnackBar(context, message: 'Profile updated successfully');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProfileAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  children: [
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
                      validator: (value) =>
                          FormValidators.requiredField(value, 'Phone'),
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
                      label: 'Address',
                      controller: _addressController,
                      validator: (value) =>
                          FormValidators.requiredField(value, 'Address'),
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
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

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
            'My Profile',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}