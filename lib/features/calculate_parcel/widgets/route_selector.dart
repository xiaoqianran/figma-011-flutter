import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// From / To location row — Figma 516:2960.
class RouteSelector extends StatelessWidget {
  const RouteSelector({
    super.key,
    required this.from,
    required this.to,
  });

  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 16,
          child: Column(
            children: [
              _RouteDot(isOrigin: true),
              Container(
                width: 2,
                height: 40,
                color: AppColors.primary,
              ),
              _RouteDot(isOrigin: false),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _LocationField(label: 'From', value: from),
              const SizedBox(height: 10),
              _LocationField(label: 'To', value: to),
            ],
          ),
        ),
      ],
    );
  }
}

class _RouteDot extends StatelessWidget {
  const _RouteDot({required this.isOrigin});

  final bool isOrigin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary20,
      ),
      child: Center(
        child: Container(
          width: isOrigin ? 5 : 8,
          height: isOrigin ? 5 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOrigin ? AppColors.primary : Colors.transparent,
          ),
          child: isOrigin
              ? null
              : const Icon(
                  Icons.near_me,
                  size: 6,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.dmSans(
              fontSize: 12,
              height: 22,
              color: AppColors.white60,
            ),
          ),
          const SizedBox(width: 29),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.dmSans(
                fontSize: 12,
                height: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}