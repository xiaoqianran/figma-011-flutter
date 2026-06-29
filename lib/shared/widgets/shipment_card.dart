import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/models/shipment.dart';

/// Shipment history card — Figma History/Pending & History/Completed.
class ShipmentCard extends StatelessWidget {
  const ShipmentCard({
    super.key,
    required this.shipment,
    this.onTap,
  });

  final Shipment shipment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 327,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tracking Number',
                      style: AppTextStyles.dmSans(
                        fontSize: 14,
                        height: 24,
                        color: AppColors.white60,
                      ),
                    ),
                    Text(
                      shipment.trackingNumber,
                      style: AppTextStyles.merriweatherBold(
                        fontSize: 16,
                        height: 26,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: shipment.status),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white30,
          ),
          const SizedBox(height: 8),
          _RouteRow(
            icon: _RouteIcon.destination,
            location: shipment.toLocation,
            time: shipment.toTime,
          ),
          const SizedBox(height: 8),
          _RouteRow(
            icon: _RouteIcon.origin,
            location: shipment.fromLocation,
            time: shipment.fromTime,
          ),
        ],
      ),
    ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ShipmentStatus status;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (status) {
      ShipmentStatus.pending => AppColors.primary,
      ShipmentStatus.completed => AppColors.green,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.merriweatherRegular(
          fontSize: 10,
          height: 12,
          color: AppColors.white,
        ),
      ),
    );
  }
}

enum _RouteIcon { destination, origin }

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.icon,
    required this.location,
    required this.time,
  });

  final _RouteIcon icon;
  final String location;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: icon == _RouteIcon.destination
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                )
              : const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.white,
                ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            location,
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          time,
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
      ],
    );
  }
}