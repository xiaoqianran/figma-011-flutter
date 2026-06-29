import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/router/app_navigation.dart';
import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/features/menu/widgets/menu_header.dart';
import 'package:fast_courier_app/shared/widgets/app_bottom_nav_bar.dart';
import 'package:fast_courier_app/shared/widgets/menu_list_row.dart';

/// Menu / profile hub — Figma 516:5428.
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTab = appTabFromLocation(GoRouterState.of(context).uri.path);

    return Scaffold(
      backgroundColor: AppColors.black1,
      extendBody: true,
      body: Column(
        children: [
          MenuHeader(
            onEditTap: () => context.push(AppRoutes.profile),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.black1,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppLayout.cardRadius),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                children: [
                  MenuListRow(
                    label: 'Notification',
                    icon: Icons.notifications_outlined,
                    onTap: () => context.push(AppRoutes.notification),
                  ),
                  MenuListRow(
                    label: 'Payment',
                    icon: Icons.account_balance_wallet_outlined,
                    onTap: () => context.push(AppRoutes.payment),
                  ),
                  MenuListRow(
                    label: 'Security',
                    icon: Icons.shield_outlined,
                    onTap: () => context.push(AppRoutes.security),
                  ),
                  MenuListRow(
                    label: 'Help & Support',
                    icon: Icons.info_outline,
                    onTap: () => context.push(AppRoutes.help),
                  ),
                  MenuListRow(
                    label: 'FAQ',
                    icon: Icons.help_outline,
                    onTap: () => context.push(AppRoutes.faq),
                  ),
                  MenuListRow(
                    label: 'Setting',
                    icon: Icons.settings_outlined,
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                  MenuListRow(
                    label: 'Logout',
                    icon: Icons.logout,
                    labelColor: AppColors.primary,
                    onTap: () => context.go(AppRoutes.login),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: currentTab,
        onTabSelected: (tab) => navigateToAppTab(context, tab),
        onFabTap: () => context.push(AppRoutes.servicesMenu),
      ),
    );
  }
}