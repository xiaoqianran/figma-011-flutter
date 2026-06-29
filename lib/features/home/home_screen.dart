import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/router/app_navigation.dart';
import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/home/widgets/home_header.dart';
import 'package:fast_courier_app/features/home/widgets/promo_carousel.dart';
import 'package:fast_courier_app/shared/models/shipment.dart';
import 'package:fast_courier_app/shared/widgets/app_bottom_nav_bar.dart';
import 'package:fast_courier_app/shared/widgets/shipment_card.dart';

/// Home screen — Figma node 515:2210.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTab = appTabFromLocation(GoRouterState.of(context).uri.path);

    return Scaffold(
      backgroundColor: AppColors.black1,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 24),
              const _ShippingNumberRow(),
              const SizedBox(height: 24),
              const PromoCarousel(),
              const SizedBox(height: 40),
              _ShipmentHistoryHeader(
                onViewAll: () => context.go(AppRoutes.history),
              ),
              const SizedBox(height: 16),
              ...mockHomeShipments.map(
                (shipment) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ShipmentCard(shipment: shipment),
                ),
              ),
            ],
          ),
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

class _ShippingNumberRow extends StatelessWidget {
  const _ShippingNumberRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.black2,
              borderRadius: BorderRadius.circular(AppLayout.buttonRadiusLg),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  size: 18,
                  color: AppColors.white,
                ),
                const SizedBox(width: 14),
                Text(
                  'Shipping number',
                  style: AppTextStyles.dmSans(
                    fontSize: 12,
                    height: 22,
                    color: AppColors.white50,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppLayout.buttonRadiusLg),
          ),
          child: const Icon(
            Icons.qr_code_scanner,
            size: 24,
            color: AppColors.black1,
          ),
        ),
      ],
    );
  }
}

class _ShipmentHistoryHeader extends StatelessWidget {
  const _ShipmentHistoryHeader({this.onViewAll});

  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Shipment History',
          style: AppTextStyles.merriweatherBold(
            fontSize: 20,
            height: 30,
            color: AppColors.white,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            'View All',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}