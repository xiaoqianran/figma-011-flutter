import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Order placed confirmation after payment.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, this.trackingNumber});

  final String? trackingNumber;

  @override
  Widget build(BuildContext context) {
    final id = trackingNumber ?? '97847548956';

    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Order Placed!',
                style: AppTextStyles.merriweatherBold(
                  fontSize: 30,
                  height: 38,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your parcel is on the way.\nTracking ID: $id',
                textAlign: TextAlign.center,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white60,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Track Order',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.go(
                  '${AppRoutes.trackOrder}?id=$id',
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Back to Home',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                backgroundColor: AppColors.black1,
                foregroundColor: AppColors.white,
                border: const BorderSide(color: AppColors.white30),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}