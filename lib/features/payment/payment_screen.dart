import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/payment/models/payment_method.dart';
import 'package:fast_courier_app/features/payment/widgets/payment_method_tile.dart';

/// Menu payment methods — based on Figma 516:4327 card selector.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedId = mockPaymentMethods.first.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PaymentScreenAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  Text(
                    'Payment Methods',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...mockPaymentMethods.map(
                    (method) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PaymentMethodTile(
                        method: method,
                        isSelected: _selectedId == method.id,
                        onTap: () =>
                            setState(() => _selectedId = method.id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _AddPaymentButton(onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentScreenAppBar extends StatelessWidget {
  const _PaymentScreenAppBar();

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
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPaymentButton extends StatelessWidget {
  const _AddPaymentButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: AppColors.black1,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Add Card',
              style: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                fontWeight: FontWeight.w500,
                color: AppColors.black1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}