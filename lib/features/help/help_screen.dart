import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/core/utils/form_validators.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Help & Support form — Figma 516:5671.
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    showAppSnackBar(
      context,
      message: 'Your question has been submitted. We will notify you soon.',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _HelpAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _HelpField(
                            controller: _nameController,
                            hint: 'Name',
                            validator: (value) =>
                                FormValidators.requiredField(value, 'Name'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _HelpField(
                            controller: _emailController,
                            hint: 'Email/Phone',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => FormValidators.requiredField(
                              value,
                              'Email or phone',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _HelpField(
                      controller: _subjectController,
                      hint: 'Subject...',
                      height: 180,
                      alignTop: true,
                      maxLines: 8,
                      validator: (value) =>
                          FormValidators.requiredField(value, 'Subject'),
                    ),
                    const SizedBox(height: 24),
                    const _HelpInfoRow(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: PrimaryButton(
                  label: 'Submit Question',
                  width: double.infinity,
                  height: 56,
                  borderRadius: AppLayout.buttonRadiusLg,
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpAppBar extends StatelessWidget {
  const _HelpAppBar();

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
            'Help',
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

class _HelpField extends StatelessWidget {
  const _HelpField({
    required this.controller,
    required this.hint,
    this.height = 56,
    this.alignTop = false,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final double height;
  final bool alignTop;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.fromLTRB(16, alignTop ? 16 : 0, 16, 16),
      alignment: alignTop ? Alignment.topLeft : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: AppTextStyles.dmSans(
          fontSize: 12,
          height: 22,
          color: AppColors.white,
        ),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.dmSans(
            fontSize: 12,
            height: 22,
            color: AppColors.white60,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          errorStyle: AppTextStyles.dmSans(
            fontSize: 10,
            height: 14,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _HelpInfoRow extends StatelessWidget {
  const _HelpInfoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'After submit question you will\nnotify very soon.',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}