import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_text_styles.dart';

/// Horizontal rule with centered "or" — Figma Other-options.
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  static const Color _lineColor = Color(0xFF8F9BB3);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: _lineColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: _lineColor,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: _lineColor,
          ),
        ),
      ],
    );
  }
}