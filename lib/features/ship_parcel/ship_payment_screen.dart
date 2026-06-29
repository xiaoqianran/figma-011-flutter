import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/services/parcel_flow_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/payment/models/payment_method.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Ship Parcel payment — Figma 516:4327.
class ShipPaymentScreen extends StatefulWidget {
  const ShipPaymentScreen({super.key});

  @override
  State<ShipPaymentScreen> createState() => _ShipPaymentScreenState();
}

class _ShipPaymentScreenState extends State<ShipPaymentScreen> {
  final ParcelFlowState _flow = ParcelFlowState.instance;
  final AppState _appState = AppState.instance;
  final TextEditingController _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _promoController.text = _flow.promoCode;
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromo() {
    final applied = _flow.applyPromoCode(_promoController.text);
    if (applied) {
      showAppSnackBar(context, message: 'Promo code applied');
      setState(() {});
    } else {
      showAppSnackBar(
        context,
        message: 'Invalid promo code',
        isError: true,
      );
    }
  }

  void _showPaymentMethodPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.black2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppLayout.cardRadius),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Payment Method',
                  style: AppTextStyles.merriweatherBold(
                    fontSize: 18,
                    height: 26,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ..._appState.paymentMethods.map((method) {
                  final isSelected =
                      _appState.selectedPaymentMethodId == method.id;
                  return ListTile(
                    leading: Icon(method.icon, color: AppColors.white),
                    title: Text(
                      method.label,
                      style: AppTextStyles.dmSans(
                        fontSize: 16,
                        height: 26,
                        color: AppColors.white,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      _appState.selectPaymentMethod(method.id);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddCardDialog() async {
    final cardController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.black2,
          title: Text(
            'Add Card',
            style: AppTextStyles.merriweatherBold(
              fontSize: 18,
              height: 26,
              color: AppColors.white,
            ),
          ),
          content: TextField(
            controller: cardController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            style: AppTextStyles.dmSans(
              fontSize: 16,
              height: 26,
              color: AppColors.white,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: 'Last 4 digits',
              hintStyle: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                color: AppColors.white60,
              ),
              counterText: '',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppLayout.buttonRadiusSm),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white60,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final lastFour = cardController.text.trim();
                if (lastFour.length != 4) {
                  showAppSnackBar(
                    dialogContext,
                    message: 'Enter exactly 4 digits',
                    isError: true,
                  );
                  return;
                }
                _appState.addPaymentMethod(lastFour);
                Navigator.of(dialogContext).pop();
                setState(() {});
              },
              child: Text(
                'Add',
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );

    cardController.dispose();
  }

  void _onPay() {
    const trackingId = '97847548956';
    _appState.incrementSentCount();
    _flow.resetAfterOrder();
    context.go('${AppRoutes.orderSuccess}?tracking=$trackingId');
  }

  PaymentMethod get _selectedMethod {
    return _appState.paymentMethods.firstWhere(
      (m) => m.id == _appState.selectedPaymentMethodId,
      orElse: () => _appState.paymentMethods.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_flow, _appState]),
      builder: (context, _) {
        final total = _flow.total;

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
                      _PaymentMethodCard(
                        label: _selectedMethod.label,
                        onTap: _showPaymentMethodPicker,
                        onAdd: _showAddCardDialog,
                      ),
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
                      _PromoCodeField(
                        controller: _promoController,
                        onApply: _applyPromo,
                      ),
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
                        value: _flow.orderAmount,
                      ),
                      const SizedBox(height: 16),
                      _SummaryRow(
                        label: 'Home Delivery',
                        value: ParcelFlowState.homeDeliveryFee,
                      ),
                      if (_flow.promoDiscount > 0) ...[
                        const SizedBox(height: 16),
                        _SummaryRow(
                          label: 'Promo (${_flow.promoCode})',
                          value: -_flow.promoDiscount,
                        ),
                      ],
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: AppColors.white30),
                      ),
                      _SummaryRow(
                        label: 'Total',
                        value: total,
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: PrimaryButton(
                    label: 'Pay \$${total.toStringAsFixed(2)}',
                    width: double.infinity,
                    height: 56,
                    borderRadius: AppLayout.buttonRadiusLg,
                    onPressed: _onPay,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
  const _PaymentMethodCard({
    required this.label,
    required this.onTap,
    required this.onAdd,
  });

  final String label;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
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
                    label,
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
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onAdd,
          child: Container(
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
  const _PromoCodeField({
    required this.controller,
    required this.onApply,
  });

  final TextEditingController controller;
  final VoidCallback onApply;

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
            child: TextField(
              controller: controller,
              style: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                color: AppColors.white,
              ),
              cursorColor: AppColors.primary,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'Enter code',
                hintStyle: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  color: AppColors.white60,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: onApply,
            child: Text(
              'Apply',
              style: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
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
    final prefix = value < 0 ? '-' : '';
    final displayValue = '$prefix\$ ${value.abs().toStringAsFixed(2)}';

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
          displayValue,
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