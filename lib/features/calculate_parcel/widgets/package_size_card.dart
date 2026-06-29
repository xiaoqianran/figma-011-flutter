import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/calculate_parcel/models/package_size.dart';

/// Horizontal package size card — Figma Mesurement 516:3928.
class PackageSizeCard extends StatelessWidget {
  const PackageSizeCard({
    super.key,
    required this.packageSize,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  final PackageSize packageSize;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double width = compact ? 327 : 214;
    final double height = compact ? 146 : 280;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.fromLTRB(
          compact ? 20 : 16,
          compact ? 24 : 20,
          compact ? 20 : 16,
          compact ? 20 : 16,
        ),
        decoration: BoxDecoration(
          color: compact ? AppColors.black1 : AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          border: isSelected && !compact
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: compact
            ? _CompactContent(packageSize: packageSize)
            : _FullContent(packageSize: packageSize),
      ),
    );
  }
}

class _FullContent extends StatelessWidget {
  const _FullContent({required this.packageSize});

  final PackageSize packageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                packageSize.name,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
              ),
            ),
            _PriceLabel(price: packageSize.price),
          ],
        ),
        const Spacer(),
        const Center(
          child: Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: AppColors.white30,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(child: _SpecColumn(
              label: 'Max. Weight',
              value: packageSize.maxWeight,
            )),
            Expanded(child: _SpecColumn(
              label: 'Max. Length',
              value: packageSize.maxLength,
            )),
          ],
        ),
      ],
    );
  }
}

class _CompactContent extends StatelessWidget {
  const _CompactContent({required this.packageSize});

  final PackageSize packageSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.inventory_2_outlined,
          size: 64,
          color: AppColors.white30,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      packageSize.name,
                      style: AppTextStyles.merriweatherBold(
                        fontSize: 16,
                        height: 26,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  _PriceLabel(price: packageSize.price),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _SpecColumn(
                    label: 'Max. Weight',
                    value: packageSize.maxWeight,
                  )),
                  Container(
                    width: 1,
                    height: 30,
                    color: AppColors.white30,
                  ),
                  Expanded(child: _SpecColumn(
                    label: 'Max. Length',
                    value: packageSize.maxLength,
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpecColumn extends StatelessWidget {
  const _SpecColumn({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.merriweatherBold(
            fontSize: 16,
            height: 26,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: r'$ ',
            style: AppTextStyles.merriweatherBold(
              fontSize: 14,
              height: 26,
              color: AppColors.white,
            ),
          ),
          TextSpan(
            text: price.toStringAsFixed(2),
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