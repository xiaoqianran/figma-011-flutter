import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/track_order/models/track_event.dart';
import 'package:fast_courier_app/features/track_order/widgets/track_map_placeholder.dart';
import 'package:fast_courier_app/features/track_order/widgets/track_search_bar.dart';
import 'package:fast_courier_app/features/track_order/widgets/track_timeline.dart';
import 'package:fast_courier_app/shared/widgets/primary_button.dart';

/// Track Order map + timeline screen — Figma 516:2507.
class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

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
                  child: const TrackSearchBar(shippingId: mockShippingId),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _TrackingBottomSheet(),
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
  const _TrackingBottomSheet();

  @override
  Widget build(BuildContext context) {
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
                mockShippingId,
                style: AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: SingleChildScrollView(
                  child: TrackTimeline(events: mockTrackEvents),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Package Details',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}