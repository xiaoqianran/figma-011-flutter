import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Profile header on Menu screen — Figma 516:5450.
class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
    required this.email,
    required this.name,
    required this.sentCount,
    required this.receivedCount,
    required this.onEditTap,
  });

  final String email;
  final String name;
  final int sentCount;
  final int receivedCount;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          const Positioned.fill(
            child: ColoredBox(color: AppColors.primary),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white30),
                    color: AppColors.white30,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email,
                        style: AppTextStyles.dmSans(
                          fontSize: 14,
                          height: 24,
                          color: AppColors.gray1,
                        ),
                      ),
                      Text(
                        name,
                        style: AppTextStyles.merriweatherBold(
                          fontSize: 20,
                          height: 30,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onEditTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.black1,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 8,
            child: _ShipmentStatsCard(
              sentCount: sentCount,
              receivedCount: receivedCount,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShipmentStatsCard extends StatelessWidget {
  const _ShipmentStatsCard({
    required this.sentCount,
    required this.receivedCount,
  });

  final int sentCount;
  final int receivedCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFFE14842),
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatColumn(
              label: 'Sent',
              value: sentCount.toString().padLeft(2, '0'),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.white,
          ),
          Expanded(
            child: _StatColumn(
              label: 'Received',
              value: receivedCount.toString().padLeft(2, '0'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyles.merriweatherBold(
            fontSize: 16,
            height: 26,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: const Color(0xFFF2F2F2),
          ),
        ),
      ],
    );
  }
}