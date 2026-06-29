import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/services/models/courier_service.dart';

/// Courier provider card — Figma Courier Service (516:3263).
class CourierServiceCard extends StatelessWidget {
  const CourierServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  final CourierService service;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 327,
        height: 140,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    service.name,
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 16,
                      height: 26,
                      color: AppColors.white,
                    ),
                  ),
                ),
                _PriceLabel(price: service.price),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Delivery :',
                  style: AppTextStyles.dmSans(
                    fontSize: 10,
                    height: 12,
                    color: AppColors.white60,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  service.deliveryTime,
                  style: AppTextStyles.merriweatherRegular(
                    fontSize: 10,
                    height: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                _InfoChip(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        service.rating.toStringAsFixed(1),
                        style: AppTextStyles.merriweatherRegular(
                          fontSize: 10,
                          height: 12,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                if (service.hasTracking) ...[
                  const SizedBox(width: 12),
                  _InfoChip(
                    child: Text(
                      'Tracking',
                      style: AppTextStyles.merriweatherRegular(
                        fontSize: 10,
                        height: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                _ActionButton(icon: Icons.call),
                const SizedBox(width: 8),
                _ActionButton(icon: Icons.near_me_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    final String amount = price.toStringAsFixed(2);

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
            text: amount,
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 12,
        color: AppColors.black1,
      ),
    );
  }
}