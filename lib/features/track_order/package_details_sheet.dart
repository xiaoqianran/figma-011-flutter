import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/services/parcel_flow_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Shows package details for the active tracking order.
void showPackageDetailsSheet(BuildContext context, {String? shippingId}) {
  final flow = ParcelFlowState.instance;
  final id = shippingId ?? '97847548956';

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.black2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppLayout.cardRadius),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Package Details',
                style: AppTextStyles.merriweatherBold(
                  fontSize: 20,
                  height: 30,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              _DetailRow(label: 'Shipping ID', value: id),
              _DetailRow(label: 'From', value: flow.from),
              _DetailRow(label: 'To', value: flow.to),
              _DetailRow(
                label: 'Packaging',
                value: '${flow.packagingType} × ${flow.packageCount}',
              ),
              _DetailRow(
                label: 'Weight',
                value: '${flow.weightKg.toStringAsFixed(0)} kg / pkg',
              ),
              if (flow.itemDescription.isNotEmpty)
                _DetailRow(label: 'Item', value: flow.itemDescription),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
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
            child: Text(
              value,
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
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