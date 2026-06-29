import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
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
  final _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesSearch(AppNotification notification, String query) {
    if (query.isEmpty) {
      return true;
    }
    final haystack =
        '${notification.highlight} ${notification.message}'.toLowerCase();
    return haystack.contains(query.toLowerCase());
  }

  bool _isPackageRelated(AppNotification notification) {
    return notification.message.toLowerCase().contains('package');
  }

  void _onNotificationTap(int index, AppNotification notification) {
    AppState.instance.markNotificationRead(index);
    if (_isPackageRelated(notification)) {
      context.push(AppRoutes.trackOrder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: AppState.instance,
          builder: (context, _) {
            final query = _searchController.text.trim();
            final allNotifications = AppState.instance.notifications;
            final notifications = <({int index, AppNotification item})>[];
            for (var i = 0; i < allNotifications.length; i++) {
              final item = allNotifications[i];
              if (_matchesSearch(item, query)) {
                notifications.add((index: i, item: item));
              }
            }

            final isEmpty = notifications.isEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _NotificationAppBar(
                  showSearch: _showSearch,
                  onSearchToggle: () {
                    setState(() {
                      _showSearch = !_showSearch;
                      if (!_showSearch) {
                        _searchController.clear();
                      }
                    });
                  },
                ),
                if (_showSearch)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.black2,
                        borderRadius:
                            BorderRadius.circular(AppLayout.cardRadius),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: AppTextStyles.dmSans(
                          fontSize: 12,
                          height: 22,
                          color: AppColors.white,
                        ),
                        cursorColor: AppColors.primary,
                        decoration: InputDecoration(
                          hintText: 'Search notifications...',
                          hintStyle: AppTextStyles.dmSans(
                            fontSize: 12,
                            height: 22,
                            color: AppColors.white60,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                if (isEmpty)
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
                          onTap: AppState.instance.markAllNotificationsRead,
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
                          entries: notifications
                              .where(
                                (entry) =>
                                    entry.item.section ==
                                    NotificationSection.today,
                              )
                              .toList(),
                          onTap: _onNotificationTap,
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
                          entries: notifications
                              .where(
                                (entry) =>
                                    entry.item.section ==
                                    NotificationSection.lastWeek,
                              )
                              .toList(),
                          onTap: _onNotificationTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NotificationAppBar extends StatelessWidget {
  const _NotificationAppBar({
    required this.showSearch,
    required this.onSearchToggle,
  });

  final bool showSearch;
  final VoidCallback onSearchToggle;

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
              onPressed: onSearchToggle,
              icon: Icon(
                showSearch ? Icons.close : Icons.search,
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
  const _NotificationSectionCard({
    required this.entries,
    required this.onTap,
  });

  final List<({int index, AppNotification item})> entries;
  final void Function(int index, AppNotification notification) onTap;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
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
          for (var i = 0; i < entries.length; i++) ...[
            NotificationTile(
              notification: entries[i].item,
              onTap: () => onTap(entries[i].index, entries[i].item),
            ),
            if (i < entries.length - 1)
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