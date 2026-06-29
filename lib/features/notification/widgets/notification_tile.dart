import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/notification/models/notification_item.dart';

/// One notification row inside a section card — Figma 516:6615.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
  });

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              notification.icon,
              size: 16,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _NotificationText(notification: notification),
          ),
        ],
      ),
    );
  }
}

class _NotificationText extends StatelessWidget {
  const _NotificationText({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    if (notification.highlight.isEmpty) {
      return Text(
        notification.message,
        style: AppTextStyles.dmSans(
          fontSize: 14,
          height: 24,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: notification.highlight,
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: ' ${notification.message}',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}