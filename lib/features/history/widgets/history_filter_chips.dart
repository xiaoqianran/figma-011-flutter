import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Filter tabs on the History screen — Figma 515:2646–515:2645.
enum HistoryFilter {
  all,
  completed,
  pending;

  String get label => switch (this) {
        HistoryFilter.all => 'All',
        HistoryFilter.completed => 'Completed',
        HistoryFilter.pending => 'Pending',
      };
}

class HistoryFilterChips extends StatelessWidget {
  const HistoryFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final HistoryFilter selected;
  final ValueChanged<HistoryFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          key: const ValueKey('history-filter-all'),
          label: HistoryFilter.all.label,
          isSelected: selected == HistoryFilter.all,
          onTap: () => onSelected(HistoryFilter.all),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _FilterChip(
            key: const ValueKey('history-filter-completed'),
            label: HistoryFilter.completed.label,
            isSelected: selected == HistoryFilter.completed,
            onTap: () => onSelected(HistoryFilter.completed),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _FilterChip(
            key: const ValueKey('history-filter-pending'),
            label: HistoryFilter.pending.label,
            isSelected: selected == HistoryFilter.pending,
            onTap: () => onSelected(HistoryFilter.pending),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    super.key,
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
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.buttonRadiusLg),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 16,
            height: 26,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.black1 : AppColors.white,
          ),
        ),
      ),
    );
  }
}