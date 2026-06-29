import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/faq/models/faq_item.dart';

class FaqFilterChips extends StatelessWidget {
  const FaqFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final FaqCategory selected;
  final ValueChanged<FaqCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final FaqCategory category in FaqCategory.values) ...[
            _FaqChip(
              label: category.label,
              isSelected: selected == category,
              onTap: () => onSelected(category),
            ),
            if (category != FaqCategory.courrier) const SizedBox(width: 14),
          ],
        ],
      ),
    );
  }
}

class _FaqChip extends StatelessWidget {
  const _FaqChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 16,
            height: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}