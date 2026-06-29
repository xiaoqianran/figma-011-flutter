import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/ship_parcel/models/ship_addon.dart';
import 'package:fast_courier_app/shared/widgets/primary_button.dart';

/// Ship Parcel payment — Figma 516:4327.
class ShipPaymentScreen extends StatelessWidget {
  const ShipPaymentScreen({super.key});

  static const double _homeDeliveryFee = 5.00;
  static const double _total = 53.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PaymentAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  const _PaymentMethodCard(),
                  const SizedBox(height: 40),
                  Text(
                    'Promo code',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _PromoCodeField(),
                  const SizedBox(height: 40),
                  Text(
                    'Order Summary',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SummaryRow(
                    label: 'Order Amount',
                    value: mockOrderAmount,
                  ),
                  const SizedBox(height: 16),
                  _SummaryRow(
                    label: 'Home Delivery',
                    value: _homeDeliveryFee,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: AppColors.white30),
                  ),
                  _SummaryRow(
                    label: 'Total',
                    value: _total,
                    isTotal: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Pay \$53.00',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentAppBar extends StatelessWidget {
  const _PaymentAppBar();

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
            'Payment',
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

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard();

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
              borderRadius: BorderRadius.circular(AppLayout.cardRadius),
            ),
            child: Row(
              children: [
                const _CardBrandIcon(),
                const SizedBox(width: 16),
                Text(
                  '....1632',
                  style: AppTextStyles.dmSans(
                    fontSize: 16,
                    height: 26,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.black1,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          ),
          child: const Icon(
            Icons.add,
            size: 24,
            color: AppColors.black1,
          ),
        ),
      ],
    );
  }
}

class _CardBrandIcon extends StatelessWidget {
  const _CardBrandIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 16,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: const BoxDecoration(
                color: Color(0xFFEA011D),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 8,
            child: Container(
              width: 13,
              height: 13,
              decoration: const BoxDecoration(
                color: Color(0xFFF59F1C),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoCodeField extends StatelessWidget {
  const _PromoCodeField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Enter code',
              style: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                color: AppColors.white60,
              ),
            ),
          ),
          Text(
            'Apply',
            style: AppTextStyles.dmSans(
              fontSize: 16,
              height: 26,
              fontWeight: FontWeight.w500,
              color: AppColors.black50,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final double value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
        Text(
          r'$' '${value.toStringAsFixed(2)}',
          style: isTotal
              ? AppTextStyles.merriweatherBlack(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.primary,
                )
              : AppTextStyles.merriweatherBold(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white,
                ),
        ),
      ],
    );
  }
}