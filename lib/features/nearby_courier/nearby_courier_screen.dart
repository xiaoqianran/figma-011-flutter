import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/features/nearby_courier/models/nearby_courier.dart';
import 'package:figma_011/features/nearby_courier/widgets/nearby_courier_card.dart';
import 'package:figma_011/features/nearby_courier/widgets/nearby_courier_search_header.dart';
import 'package:figma_011/features/nearby_courier/widgets/nearby_filter_tabs.dart';
import 'package:figma_011/features/nearby_courier/widgets/nearby_map_placeholder.dart';

/// Nearby Courier list & map views — Figma 515:4018 / 515:4061.
class NearbyCourierScreen extends StatefulWidget {
  const NearbyCourierScreen({super.key});

  @override
  State<NearbyCourierScreen> createState() => _NearbyCourierScreenState();
}

class _NearbyCourierScreenState extends State<NearbyCourierScreen> {
  NearbyFilter _filter = NearbyFilter.nearby;
  bool _isMapView = false;

  List<NearbyCourier> get _filteredCouriers {
    return switch (_filter) {
      NearbyFilter.openNow =>
        mockNearbyCouriers.where((c) => c.isOpen).toList(),
      NearbyFilter.nearby => mockNearbyCouriers,
      NearbyFilter.visited =>
        mockNearbyCouriers.where((c) => c.isVisited).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NearbyCourierSearchHeader(
                  onBack: () => context.pop(),
                ),
                NearbyFilterTabs(
                  selected: _filter,
                  onSelected: (filter) => setState(() => _filter = filter),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _isMapView
                      ? _MapViewContent(couriers: _filteredCouriers)
                      : _ListViewContent(couriers: _filteredCouriers),
                ),
              ],
            ),
            Positioned(
              right: 24,
              bottom: 24,
              child: _ViewModeFab(
                isMapView: _isMapView,
                onPressed: () => setState(() => _isMapView = !_isMapView),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListViewContent extends StatelessWidget {
  const _ListViewContent({required this.couriers});

  final List<NearbyCourier> couriers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      itemCount: couriers.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return NearbyCourierCard(courier: couriers[index]);
      },
    );
  }
}

class _MapViewContent extends StatelessWidget {
  const _MapViewContent({required this.couriers});

  final List<NearbyCourier> couriers;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: NearbyMapPlaceholder()),
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: couriers.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return NearbyCourierCard(
                  courier: couriers[index],
                  compact: true,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ViewModeFab extends StatelessWidget {
  const _ViewModeFab({
    required this.isMapView,
    required this.onPressed,
  });

  final bool isMapView;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        ),
        child: Icon(
          isMapView ? Icons.view_list : Icons.confirmation_number_outlined,
          size: 20,
          color: AppColors.white,
        ),
      ),
    );
  }
}