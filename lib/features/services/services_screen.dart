import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/services/models/courier_service.dart';
import 'package:figma_011/features/services/widgets/courier_service_card.dart';
import 'package:figma_011/features/services/widgets/services_search_bar.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Compare Price / Services screen — Figma node 516:3227.
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String _selectedId = mockCourierServices.first.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ServicesAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                children: [
                  const ServicesSearchBar(),
                  const SizedBox(height: 24),
                  ...mockCourierServices.map(
                    (service) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CourierServiceCard(
                        service: service,
                        isSelected: _selectedId == service.id,
                        onTap: () => setState(() => _selectedId = service.id),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'Continue with Fast',
                    width: double.infinity,
                    height: 56,
                    borderRadius: AppLayout.buttonRadiusLg,
                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}

class _ServicesAppBar extends StatelessWidget {
  const _ServicesAppBar();

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
            'Compare Price',
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