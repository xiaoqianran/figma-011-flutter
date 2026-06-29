import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Inline label + value field with bottom border — Figma auth input style.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onToggleVisibility,
    this.showVisibilityToggle = false,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onToggleVisibility;
  final bool showVisibilityToggle;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: AppColors.white60,
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                cursorColor: AppColors.primary,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  errorStyle: TextStyle(fontSize: 11),
                ),
              ),
            ),
            if (showVisibilityToggle)
              IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.white,
                  size: 18,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.white30,
        ),
      ],
    );
  }
}