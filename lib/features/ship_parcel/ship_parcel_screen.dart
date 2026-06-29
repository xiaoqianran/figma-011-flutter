import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/parcel_flow_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/calculate_parcel/widgets/route_selector.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Ship Parcel packaging step — Figma 516:4180.
class ShipParcelScreen extends StatefulWidget {
  const ShipParcelScreen({super.key});

  @override
  State<ShipParcelScreen> createState() => _ShipParcelScreenState();
}

class _ShipParcelScreenState extends State<ShipParcelScreen> {
  final ParcelFlowState _flow = ParcelFlowState.instance;
  late final TextEditingController _fromController;
  late final TextEditingController _toController;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController(text: _flow.from);
    _toController = TextEditingController(text: _flow.to);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _syncFrom(String value) {
    _flow.updateRoute(from: value);
  }

  void _syncTo(String value) {
    _flow.updateRoute(to: value);
  }

  void _selectPackagingType(String type) {
    _flow.selectPackagingType(type);
    setState(() {});
  }

  void _changePackageCount(int delta) {
    final next = (_flow.packageCount + delta).clamp(1, 10);
    if (next != _flow.packageCount) {
      _flow.updatePackageCount(next);
      setState(() {});
    }
  }

  void _changeWeight(double delta) {
    final next = (_flow.weightKg + delta).clamp(1.0, 10.0);
    if (next != _flow.weightKg) {
      _flow.updateWeightKg(next);
      setState(() {});
    }
  }

  void _onAddPackage() {
    if (_flow.packageCount >= 10) {
      showAppSnackBar(
        context,
        message: 'Maximum 10 packages allowed',
        isError: true,
      );
      return;
    }
    _flow.addExtraPackage();
    showAppSnackBar(context, message: 'Package added');
  }

  void _onNext() {
    if (_fromController.text.trim().isEmpty || _toController.text.trim().isEmpty) {
      showAppSnackBar(
        context,
        message: 'Please enter both From and To locations',
        isError: true,
      );
      return;
    }
    if (_flow.packageCount < 1) {
      showAppSnackBar(
        context,
        message: 'Please add at least one package',
        isError: true,
      );
      return;
    }
    if (_flow.weightKg <= 0) {
      showAppSnackBar(
        context,
        message: 'Please set a valid package weight',
        isError: true,
      );
      return;
    }
    context.push(AppRoutes.shipParcelDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ShipParcelAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  RouteSelector(
                    fromController: _fromController,
                    toController: _toController,
                    onFromChanged: _syncFrom,
                    onToChanged: _syncTo,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Packaging',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: ParcelFlowState.packagingTypes.map((type) {
                      return _PackagingTypeChip(
                        label: type,
                        isSelected: _flow.packagingType == type,
                        onTap: () => _selectPackagingType(type),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  _StepperField(
                    label: '# Of Packages',
                    value: '${_flow.packageCount}',
                    hint: 'Max 10',
                    onDecrement: () => _changePackageCount(-1),
                    onIncrement: () => _changePackageCount(1),
                    canDecrement: _flow.packageCount > 1,
                    canIncrement: _flow.packageCount < 10,
                  ),
                  const SizedBox(height: 16),
                  _StepperField(
                    label: 'Weight Per Package',
                    value: '${_flow.weightKg.toStringAsFixed(0)} kg',
                    hint: 'Max Weight 10 kg',
                    onDecrement: () => _changeWeight(-1),
                    onIncrement: () => _changeWeight(1),
                    canDecrement: _flow.weightKg > 1,
                    canIncrement: _flow.weightKg < 10,
                  ),
                  const SizedBox(height: 24),
                  const _InfoRow(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: PrimaryButton(
                label: 'Add Package',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                backgroundColor: AppColors.black1,
                foregroundColor: AppColors.white,
                border: const BorderSide(color: AppColors.white30),
                onPressed: _onAddPackage,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Next',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: _onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipParcelAppBar extends StatelessWidget {
  const _ShipParcelAppBar();

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
            'Ship Parcel',
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

class _PackagingTypeChip extends StatelessWidget {
  const _PackagingTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.white30,
            width: isSelected ? 2 : 1,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 16,
            height: 26,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _StepperField extends StatelessWidget {
  const _StepperField({
    required this.label,
    required this.value,
    required this.hint,
    required this.onDecrement,
    required this.onIncrement,
    required this.canDecrement,
    required this.canIncrement,
  });

  final String label;
  final String value;
  final String hint;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final bool canDecrement;
  final bool canIncrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.dmSans(
            fontSize: 14,
            height: 24,
            color: AppColors.white60,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.black2,
            borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
          ),
          child: Row(
            children: [
              _StepperButton(
                icon: Icons.remove,
                onTap: canDecrement ? onDecrement : null,
              ),
              const SizedBox(width: 12),
              Text(
                value,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                hint,
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
              ),
              const SizedBox(width: 12),
              _StepperButton(
                icon: Icons.add,
                onTap: canIncrement ? onIncrement : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.white : AppColors.white30,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: AppColors.black1,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Calculate shipping cost base on order\n'
            'value or size of item',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}