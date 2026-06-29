import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Bottom navigation tabs for the main shell — Figma 515:2617.
enum AppNavTab { home, history, chat, menu }

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentTab,
    this.onTabSelected,
    this.onFabTap,
  });

  final AppNavTab currentTab;
  final ValueChanged<AppNavTab>? onTabSelected;
  final VoidCallback? onFabTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.bottomNavHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 34, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      label: 'Home',
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      isActive: currentTab == AppNavTab.home,
                      onTap: () => onTabSelected?.call(AppNavTab.home),
                    ),
                    _NavItem(
                      label: 'History',
                      icon: Icons.access_time,
                      isActive: currentTab == AppNavTab.history,
                      onTap: () => onTabSelected?.call(AppNavTab.history),
                    ),
                    const SizedBox(width: 56),
                    _NavItem(
                      label: 'Chat',
                      icon: Icons.chat_bubble_outline,
                      isActive: currentTab == AppNavTab.chat,
                      onTap: () => onTabSelected?.call(AppNavTab.chat),
                    ),
                    _NavItem(
                      label: 'Menu',
                      icon: Icons.grid_view,
                      isActive: currentTab == AppNavTab.menu,
                      onTap: () => onTabSelected?.call(AppNavTab.menu),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: GestureDetector(
              onTap: onFabTap,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.black1,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppColors.primary : AppColors.white30;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? (activeIcon ?? icon) : icon,
              size: 16,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.dmSans(
                fontSize: 10,
                height: 12,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            if (isActive)
              Container(
                width: 28,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightRed,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}