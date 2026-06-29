import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/payment/models/payment_method.dart';

/// Saved card or wallet row — Figma 516:4547.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    this.onTap,
  });

  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              method.icon,
              size: 24,
              color: AppColors.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                method.label,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (method.isDefault)
              Text(
                'Default',
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
              ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.check_circle,
                size: 20,
                color: AppColors.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}