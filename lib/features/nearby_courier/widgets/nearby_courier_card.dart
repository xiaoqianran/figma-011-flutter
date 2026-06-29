import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/nearby_courier/models/nearby_courier.dart';

/// Courier location card — Figma Courier Service/Large & Small.
class NearbyCourierCard extends StatelessWidget {
  const NearbyCourierCard({
    super.key,
    required this.courier,
    this.compact = false,
    this.onCall,
    this.onDirections,
  });

  final NearbyCourier courier;
  final bool compact;
  final VoidCallback? onCall;
  final VoidCallback? onDirections;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = compact ? 300 : 327;
    final EdgeInsets padding = compact
        ? const EdgeInsets.fromLTRB(16, 20, 16, 16)
        : const EdgeInsets.fromLTRB(20, 24, 20, 20);

    return Container(
      width: cardWidth,
      height: 140,
      padding: padding,
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
                child: Text(
                  courier.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.merriweatherBold(
                    fontSize: 16,
                    height: 26,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                courier.statusLabel,
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  fontWeight: FontWeight.w700,
                  color: courier.isOpen ? AppColors.green : AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            courier.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white60,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Flexible(
                child: _InfoChip(
                  child: Text(
                    courier.hours,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.merriweatherRegular(
                      fontSize: 10,
                      height: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
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
                      courier.rating.toStringAsFixed(1),
                      style: AppTextStyles.merriweatherRegular(
                        fontSize: 10,
                        height: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _ActionButton(icon: Icons.call, onTap: onCall),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Icons.near_me_outlined,
                onTap: onDirections,
              ),
            ],
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
  const _ActionButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}