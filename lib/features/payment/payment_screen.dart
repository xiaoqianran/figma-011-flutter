import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/payment/widgets/payment_method_tile.dart';

/// Menu payment methods — based on Figma 516:4327 card selector.
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  Future<void> _showAddCardDialog(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final added = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.black2,
        title: Text(
          'Add Card',
          style: AppTextStyles.dmSans(
            fontSize: 16,
            height: 26,
            color: AppColors.white,
          ),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 4,
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              labelText: 'Last 4 digits',
              labelStyle: AppTextStyles.dmSans(
                fontSize: 12,
                height: 22,
                color: AppColors.white60,
              ),
              counterText: '',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white30),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().length != 4) {
                return 'Enter 4 digits';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Cancel',
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
                color: AppColors.white60,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() != true) {
                return;
              }
              Navigator.pop(dialogContext, true);
            },
            child: Text(
              'Add',
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );

    if (added == true && context.mounted) {
      AppState.instance.addPaymentMethod(controller.text.trim());
      showAppSnackBar(context, message: 'Card added successfully');
    }
    controller.dispose();
  }

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
              child: ListenableBuilder(
                listenable: AppState.instance,
                builder: (context, _) {
                  final state = AppState.instance;
                  final methods = state.paymentMethods;
                  final selectedId = state.selectedPaymentMethodId;

                  return ListView(
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
                      ...methods.map(
                        (method) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PaymentMethodTile(
                            method: method,
                            isSelected: selectedId == method.id,
                            onTap: () => state.selectPaymentMethod(method.id),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _AddPaymentButton(
                        onTap: () => _showAddCardDialog(context),
                      ),
                    ],
                  );
                },
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