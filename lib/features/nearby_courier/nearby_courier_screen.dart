import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
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
  final _searchController = TextEditingController();
  NearbyFilter _filter = NearbyFilter.nearby;
  bool _isMapView = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<NearbyCourier> get _filteredCouriers {
    final query = _searchController.text.trim().toLowerCase();
    var couriers = switch (_filter) {
      NearbyFilter.openNow =>
        mockNearbyCouriers.where((c) => c.isOpen).toList(),
      NearbyFilter.nearby => mockNearbyCouriers,
      NearbyFilter.visited =>
        mockNearbyCouriers.where((c) => c.isVisited).toList(),
    };

    if (query.isNotEmpty) {
      couriers = couriers
          .where(
            (c) =>
                c.name.toLowerCase().contains(query) ||
                c.address.toLowerCase().contains(query),
          )
          .toList();
    }

    return couriers;
  }

  void _onCall(NearbyCourier courier) {
    showAppSnackBar(context, message: 'Calling ${courier.name}...');
  }

  void _onDirections(NearbyCourier courier) {
    showAppSnackBar(
      context,
      message: 'Opening directions to ${courier.name}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final couriers = _filteredCouriers;

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
                  searchController: _searchController,
                  onSearchChanged: (_) => setState(() {}),
                ),
                NearbyFilterTabs(
                  selected: _filter,
                  onSelected: (filter) => setState(() => _filter = filter),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _isMapView
                      ? _MapViewContent(
                          couriers: couriers,
                          onCall: _onCall,
                          onDirections: _onDirections,
                        )
                      : _ListViewContent(
                          couriers: couriers,
                          onCall: _onCall,
                          onDirections: _onDirections,
                        ),
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
  const _ListViewContent({
    required this.couriers,
    required this.onCall,
    required this.onDirections,
  });

  final List<NearbyCourier> couriers;
  final void Function(NearbyCourier courier) onCall;
  final void Function(NearbyCourier courier) onDirections;

  @override
  Widget build(BuildContext context) {
    if (couriers.isEmpty) {
      return Center(
        child: Text(
          'No couriers found.',
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      itemCount: couriers.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final courier = couriers[index];
        return NearbyCourierCard(
          courier: courier,
          onCall: () => onCall(courier),
          onDirections: () => onDirections(courier),
        );
      },
    );
  }
}

class _MapViewContent extends StatelessWidget {
  const _MapViewContent({
    required this.couriers,
    required this.onCall,
    required this.onDirections,
  });

  final List<NearbyCourier> couriers;
  final void Function(NearbyCourier courier) onCall;
  final void Function(NearbyCourier courier) onDirections;

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
                final courier = couriers[index];
                return NearbyCourierCard(
                  courier: courier,
                  compact: true,
                  onCall: () => onCall(courier),
                  onDirections: () => onDirections(courier),
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