import 'package:flutter/material.dart';

/// Saved payment method — Figma ship payment card 516:4547.
class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.label,
    required this.icon,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final IconData icon;
  final bool isDefault;
}

/// Mock payment methods from Figma copy.
const List<PaymentMethod> mockPaymentMethods = [
  PaymentMethod(
    id: 'card-1632',
    label: '....1632',
    icon: Icons.credit_card,
    isDefault: true,
  ),
  PaymentMethod(
    id: 'wallet',
    label: 'Fast Wallet',
    icon: Icons.account_balance_wallet_outlined,
  ),
];