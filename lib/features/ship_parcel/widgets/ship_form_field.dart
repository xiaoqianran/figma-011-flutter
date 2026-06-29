import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Single-line or multiline form field — Figma 516:4290.
class ShipFormField extends StatelessWidget {
  const ShipFormField({
    super.key,
    required this.placeholder,
    this.height = 56,
    this.trailing,
    this.value,
    this.onTap,
    this.controller,
    this.onChanged,
    this.readOnly = false,
  });

  final String placeholder;
  final double height;
  final Widget? trailing;
  final String? value;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final bool editable = controller != null;

    final Widget fieldChild = editable
        ? TextField(
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: height > 56 ? null : 1,
            expands: height > 56,
            textAlignVertical:
                height > 56 ? TextAlignVertical.top : TextAlignVertical.center,
            style: AppTextStyles.dmSans(
              fontSize: 16,
              height: 26,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                color: AppColors.white60,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          )
        : Text(
            value ?? placeholder,
            style: value == null
                ? AppTextStyles.dmSans(
                    fontSize: 16,
                    height: 26,
                    color: AppColors.white60,
                  )
                : AppTextStyles.dmSans(
                    fontSize: 16,
                    height: 26,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
          );

    final rowChildren = <Widget>[
      Expanded(child: fieldChild),
    ];
    if (trailing != null) {
      rowChildren.add(trailing!);
    }

    final Widget content = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
      ),
      child: Row(
        crossAxisAlignment:
            height > 56 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (height > 56) const SizedBox(height: 16),
          ...rowChildren,
        ],
      ),
    );

    if (onTap == null || editable) {
      return content;
    }

    return GestureDetector(
      onTap: onTap,
      child: content,
    );
  }
}