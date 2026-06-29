import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/calculate_parcel/models/package_size.dart';
import 'package:figma_011/features/calculate_parcel/widgets/package_size_card.dart';
import 'package:figma_011/features/calculate_parcel/widgets/route_selector.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Calculate Parcel form — Figma 516:2931.
class CalculateParcelScreen extends StatefulWidget {
  const CalculateParcelScreen({super.key});

  @override
  State<CalculateParcelScreen> createState() => _CalculateParcelScreenState();
}

class _CalculateParcelScreenState extends State<CalculateParcelScreen> {
  String _selectedId = mockPackageSizes.first.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CalculateParcelAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  const RouteSelector(
                    from: 'Gouripur, Daudkandi',
                    to: 'Tejgaon, Dhaka',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Package Size',
                          style: AppTextStyles.merriweatherBold(
                            fontSize: 20,
                            height: 30,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      _ScanButton(onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: mockPackageSizes.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final size = mockPackageSizes[index];
                        return PackageSizeCard(
                          packageSize: size,
                          isSelected: _selectedId == size.id,
                          onTap: () => setState(() => _selectedId = size.id),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _InfoRow(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Calculate',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                backgroundColor: AppColors.black1,
                foregroundColor: AppColors.white,
                border: const BorderSide(color: AppColors.white30),
                onPressed: () => context.push(AppRoutes.calculateResult),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalculateParcelAppBar extends StatelessWidget {
  const _CalculateParcelAppBar();

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
            'Calculate Parcel',
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

class _ScanButton extends StatelessWidget {
  const _ScanButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppLayout.buttonRadiusSm),
        ),
        child: const Icon(
          Icons.qr_code_scanner,
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