import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_navigation.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/services/tracking_service.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/home/widgets/home_header.dart';
import 'package:figma_011/features/home/widgets/promo_carousel.dart';
import 'package:figma_011/shared/models/shipment.dart';
import 'package:figma_011/shared/widgets/app_bottom_nav_bar.dart';
import 'package:figma_011/shared/widgets/shipment_card.dart';

/// Home screen — Figma node 515:2210.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openTrackOrder(String trackingNumber) {
    final id = normalizeTrackingId(trackingNumber);
    context.push('${AppRoutes.trackOrder}?id=$id');
  }

  void _onSearchTap() {
    if (_searchFocusNode.hasFocus) {
      context.push(AppRoutes.trackOrder);
    } else {
      _searchFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = appTabFromLocation(GoRouterState.of(context).uri.path);
    final appState = AppState.instance;

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
              HomeHeader(
                userName: appState.firstName,
                onSearchTap: _onSearchTap,
              ),
              const SizedBox(height: 24),
              _ShippingNumberRow(
                focusNode: _searchFocusNode,
                onSubmit: _openTrackOrder,
              ),
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
                  child: ShipmentCard(
                    shipment: shipment,
                    onTap: () => _openTrackOrder(shipment.trackingNumber),
                  ),
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

class _ShippingNumberRow extends StatefulWidget {
  const _ShippingNumberRow({
    required this.focusNode,
    required this.onSubmit,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onSubmit;

  @override
  State<_ShippingNumberRow> createState() => _ShippingNumberRowState();
}

class _ShippingNumberRowState extends State<_ShippingNumberRow> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      return;
    }
    widget.onSubmit(value);
  }

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
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: widget.focusNode,
                    onSubmitted: (_) => _submit(),
                    style: AppTextStyles.dmSans(
                      fontSize: 12,
                      height: 22,
                      color: AppColors.white,
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: 'Shipping number',
                      hintStyle: AppTextStyles.dmSans(
                        fontSize: 12,
                        height: 22,
                        color: AppColors.white50,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            showAppSnackBar(context, message: 'QR scanner opened');
          },
          child: Container(
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