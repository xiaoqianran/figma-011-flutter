import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/notification/models/notification_item.dart';
import 'package:figma_011/features/notification/widgets/notification_tile.dart';

/// Notification center — Figma 516:6567 / 516:6632.
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<AppNotification> _notifications =
      List<AppNotification>.from(mockNotifications);

  bool get _isEmpty => _notifications.isEmpty;

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications
          .map(
            (n) => AppNotification(
              message: n.message,
              highlight: n.highlight,
              icon: n.icon,
              section: n.section,
              isRead: true,
            ),
          )
          .toList();
    });
  }

  List<AppNotification> _forSection(NotificationSection section) {
    return _notifications.where((n) => n.section == section).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _NotificationAppBar(),
            if (_isEmpty)
              const Expanded(child: _EmptyNotificationState())
            else ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today',
                      style: AppTextStyles.dmSans(
                        fontSize: 12,
                        height: 22,
                        color: AppColors.white60,
                      ),
                    ),
                    GestureDetector(
                      onTap: _markAllAsRead,
                      child: Text(
                        'Mark All as Read',
                        style: AppTextStyles.dmSans(
                          fontSize: 14,
                          height: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  children: [
                    _NotificationSectionCard(
                      notifications: _forSection(
                        NotificationSection.today,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Last Week',
                      style: AppTextStyles.dmSans(
                        fontSize: 12,
                        height: 22,
                        color: AppColors.white60,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _NotificationSectionCard(
                      notifications: _forSection(
                        NotificationSection.lastWeek,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NotificationAppBar extends StatelessWidget {
  const _NotificationAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Notification',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyNotificationState extends StatelessWidget {
  const _EmptyNotificationState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Opps, no notification yet!',
        style: AppTextStyles.dmSans(
          fontSize: 16,
          height: 24,
          color: AppColors.white60,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _NotificationSectionCard extends StatelessWidget {
  const _NotificationSectionCard({required this.notifications});

  final List<AppNotification> notifications;

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      child: Column(
        children: [
          for (var i = 0; i < notifications.length; i++) ...[
            NotificationTile(notification: notifications[i]),
            if (i < notifications.length - 1)
              const Divider(
                color: AppColors.black1,
                height: 1,
              ),
          ],
        ],
      ),
    );
  }
}