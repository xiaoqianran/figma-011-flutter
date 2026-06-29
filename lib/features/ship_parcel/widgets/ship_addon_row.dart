import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/ship_parcel/models/ship_addon.dart';

/// Checkbox add-on row with price — Figma 516:4304.
class ShipAddonRow extends StatelessWidget {
  const ShipAddonRow({
    super.key,
    required this.addon,
    required this.isSelected,
    required this.onChanged,
  });

  final ShipAddon addon;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: isSelected,
              onChanged: (value) => onChanged(value ?? false),
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
              side: const BorderSide(color: AppColors.white30),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              addon.label,
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
                color: AppColors.white,
              ),
            ),
          ),
          Text(
            r'$' '${addon.price.toStringAsFixed(2)}',
            style: AppTextStyles.merriweatherBold(
              fontSize: 16,
              height: 26,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}