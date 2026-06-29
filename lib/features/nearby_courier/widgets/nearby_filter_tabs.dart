import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Filter tabs on Nearby Courier — Figma 516:2369–516:2373.
enum NearbyFilter {
  openNow,
  nearby,
  visited;

  String get label => switch (this) {
        NearbyFilter.openNow => 'Open Now',
        NearbyFilter.nearby => 'Nearby',
        NearbyFilter.visited => 'Visited',
      };
}

class NearbyFilterTabs extends StatelessWidget {
  const NearbyFilterTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final NearbyFilter selected;
  final ValueChanged<NearbyFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        children: [
          _FilterIconButton(),
          const SizedBox(width: 14),
          _FilterTab(
            label: NearbyFilter.openNow.label,
            isSelected: selected == NearbyFilter.openNow,
            onTap: () => onSelected(NearbyFilter.openNow),
          ),
          const SizedBox(width: 14),
          _FilterTab(
            label: NearbyFilter.nearby.label,
            isSelected: selected == NearbyFilter.nearby,
            onTap: () => onSelected(NearbyFilter.nearby),
          ),
          const SizedBox(width: 14),
          _FilterTab(
            label: NearbyFilter.visited.label,
            isSelected: selected == NearbyFilter.visited,
            onTap: () => onSelected(NearbyFilter.visited),
          ),
        ],
      ),
    );
  }
}

class _FilterIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.tune,
        size: 20,
        color: AppColors.black1,
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
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