import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fast_courier_app/core/constants/app_layout.dart';
import 'package:fast_courier_app/core/router/app_routes.dart';
import 'package:fast_courier_app/core/theme/app_colors.dart';
import 'package:fast_courier_app/core/theme/app_text_styles.dart';
import 'package:fast_courier_app/features/ship_parcel/models/ship_addon.dart';
import 'package:fast_courier_app/features/ship_parcel/widgets/delivery_estimate_row.dart';
import 'package:fast_courier_app/features/ship_parcel/widgets/ship_addon_row.dart';
import 'package:fast_courier_app/features/ship_parcel/widgets/ship_form_field.dart';
import 'package:fast_courier_app/shared/widgets/primary_button.dart';

/// Ship Parcel details step — Figma 516:4258.
class ShipParcelDetailsScreen extends StatefulWidget {
  const ShipParcelDetailsScreen({super.key});

  @override
  State<ShipParcelDetailsScreen> createState() =>
      _ShipParcelDetailsScreenState();
}

class _ShipParcelDetailsScreenState extends State<ShipParcelDetailsScreen> {
  late final Map<String, bool> _addonSelection = {
    for (final ShipAddon addon in mockShipAddons)
      addon.id: addon.defaultSelected,
  };

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
                  ShipFormField(
                    placeholder: '24 Jun, 16:32',
                    value: '24 Jun, 16:32',
                    trailing: const Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ShipFormField(
                    placeholder: 'Internal Reference ID',
                  ),
                  const SizedBox(height: 16),
                  const ShipFormField(
                    placeholder: 'Item Name & Description',
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  ShipFormField(
                    placeholder: 'More Pickup Details',
                    value: 'More Pickup Details',
                    trailing: const Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  ...mockShipAddons.map(
                    (addon) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ShipAddonRow(
                        addon: addon,
                        isSelected: _addonSelection[addon.id] ?? false,
                        onChanged: (selected) {
                          setState(() => _addonSelection[addon.id] = selected);
                        },
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.white30),
                  const SizedBox(height: 16),
                  const DeliveryEstimateRow(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Ship',
                width: double.infinity,
                height: 56,
                borderRadius: AppLayout.buttonRadiusLg,
                onPressed: () => context.push(AppRoutes.shipPayment),
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