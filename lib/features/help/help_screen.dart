import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Help & Support form — Figma 516:5671.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
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
                      Expanded(child: _HelpField(placeholder: 'Name')),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _HelpField(placeholder: 'Email/Phone'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _HelpField(
                    placeholder: 'Subject...',
                    height: 180,
                    alignTop: true,
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
                onPressed: () => context.pop(),
              ),
            ),
          ],
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
    required this.placeholder,
    this.height = 56,
    this.alignTop = false,
  });

  final String placeholder;
  final double height;
  final bool alignTop;

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
      child: Text(
        placeholder,
        style: AppTextStyles.dmSans(
          fontSize: 12,
          height: 22,
          color: AppColors.white60,
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