import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_navigation.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/history/widgets/history_filter_chips.dart';
import 'package:figma_011/shared/models/shipment.dart';
import 'package:figma_011/shared/widgets/app_bottom_nav_bar.dart';
import 'package:figma_011/shared/widgets/shipment_card.dart';

/// Delivery History screen — Figma node 515:2618.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryFilter _filter = HistoryFilter.all;

  List<Shipment> get _filteredShipments {
    return switch (_filter) {
      HistoryFilter.all => mockHistoryShipments,
      HistoryFilter.completed => mockHistoryShipments
          .where((s) => s.status == ShipmentStatus.completed)
          .toList(),
      HistoryFilter.pending => mockHistoryShipments
          .where((s) => s.status == ShipmentStatus.pending)
          .toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = appTabFromLocation(GoRouterState.of(context).uri.path);

    return Scaffold(
      backgroundColor: AppColors.black1,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HistoryAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: HistoryFilterChips(
                selected: _filter,
                onSelected: (filter) => setState(() => _filter = filter),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                itemCount: _filteredShipments.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return ShipmentCard(shipment: _filteredShipments[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: currentTab,
        onTabSelected: (tab) => navigateToAppTab(context, tab),
        onFabTap: () => context.push(AppRoutes.servicesMenu),
      ),
    );
  }
}

class _HistoryAppBar extends StatelessWidget {
  const _HistoryAppBar();

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
              onPressed: () => context.go(AppRoutes.home),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Delivery History',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}