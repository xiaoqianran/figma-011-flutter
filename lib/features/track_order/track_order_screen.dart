import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/services/tracking_service.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/track_order/models/track_event.dart';
import 'package:figma_011/features/track_order/package_details_sheet.dart';
import 'package:figma_011/features/track_order/widgets/track_map_placeholder.dart';
import 'package:figma_011/features/track_order/widgets/track_search_bar.dart';
import 'package:figma_011/features/track_order/widgets/track_timeline.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Track Order map + timeline screen — Figma 516:2507.
class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key, this.initialShippingId});

  final String? initialShippingId;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late final TextEditingController _searchController;
  TrackingLookupResult? _result;

  @override
  void initState() {
    super.initState();
    final initialId = widget.initialShippingId ?? mockShippingId;
    _searchController = TextEditingController(text: initialId);
    _result = lookupTracking(initialId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final result = lookupTracking(_searchController.text);
    if (result.notFound) {
      setState(() => _result = null);
      showAppSnackBar(
        context,
        message: 'Tracking ID not found',
        isError: true,
      );
      return;
    }
    setState(() => _result = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: Stack(
        children: [
          const Positioned.fill(child: TrackMapPlaceholder()),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _TrackOrderAppBar(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 90, 0),
                  child: TrackSearchBar(
                    controller: _searchController,
                    onSearch: _onSearch,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _TrackingBottomSheet(
              result: _result,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackOrderAppBar extends StatelessWidget {
  const _TrackOrderAppBar();

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
            'Track Order',
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

class _TrackingBottomSheet extends StatelessWidget {
  const _TrackingBottomSheet({required this.result});

  final TrackingLookupResult? result;

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return Container(
        height: 200,
        decoration: const BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppLayout.cardRadius),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Center(
            child: Text(
              'Enter a shipping ID to track your order',
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
                color: AppColors.white60,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 418,
      decoration: const BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppLayout.cardRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Shipping ID',
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: AppColors.white60,
                ),
              ),
              Text(
                result!.shippingId,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: TrackTimeline(events: result!.events),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Package Details',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => showPackageDetailsSheet(
                  context,
                  shippingId: result!.shippingId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}