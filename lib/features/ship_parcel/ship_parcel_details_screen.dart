import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/parcel_flow_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/ship_parcel/models/ship_addon.dart';
import 'package:figma_011/features/ship_parcel/widgets/delivery_estimate_row.dart';
import 'package:figma_011/features/ship_parcel/widgets/ship_addon_row.dart';
import 'package:figma_011/features/ship_parcel/widgets/ship_form_field.dart';
import 'package:figma_011/shared/widgets/primary_button.dart';

/// Ship Parcel details step — Figma 516:4258.
class ShipParcelDetailsScreen extends StatefulWidget {
  const ShipParcelDetailsScreen({super.key});

  @override
  State<ShipParcelDetailsScreen> createState() =>
      _ShipParcelDetailsScreenState();
}

class _ShipParcelDetailsScreenState extends State<ShipParcelDetailsScreen> {
  final ParcelFlowState _flow = ParcelFlowState.instance;
  late final TextEditingController _referenceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _pickupDetailsController;

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    _referenceController = TextEditingController(text: _flow.referenceId);
    _descriptionController =
        TextEditingController(text: _flow.itemDescription);
    _pickupDetailsController =
        TextEditingController(text: _flow.pickupDetails);
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _descriptionController.dispose();
    _pickupDetailsController.dispose();
    super.dispose();
  }

  String _formatPickupDate(DateTime date, TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '${date.day} ${_months[date.month - 1]}, $hour:$minute';
  }

  Future<void> _pickPickupDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.black2,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate == null || !mounted) {
      return;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.black2,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime == null) {
      return;
    }

    _flow.updatePickupDate(_formatPickupDate(pickedDate, pickedTime));
    setState(() {});
  }

  void _showPickupDetailsDialog() {
    final dialogController =
        TextEditingController(text: _pickupDetailsController.text);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.black2,
          title: Text(
            'Pickup Details',
            style: AppTextStyles.merriweatherBold(
              fontSize: 18,
              height: 26,
              color: AppColors.white,
            ),
          ),
          content: TextField(
            controller: dialogController,
            maxLines: 4,
            style: AppTextStyles.dmSans(
              fontSize: 16,
              height: 26,
              color: AppColors.white,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: 'Enter pickup instructions',
              hintStyle: AppTextStyles.dmSans(
                fontSize: 16,
                height: 26,
                color: AppColors.white60,
              ),
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
                final value = dialogController.text.trim();
                _pickupDetailsController.text = value;
                _flow.updatePickupDetails(value);
                setState(() {});
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Save',
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
    ).then((_) => dialogController.dispose());
  }

  void _toggleAddon(String id, bool selected) {
    _flow.updateAddon(id, selected);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasPickupDetails = _flow.pickupDetails.isNotEmpty;

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
                    placeholder: _flow.pickupDate,
                    value: _flow.pickupDate,
                    trailing: const Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: AppColors.white,
                    ),
                    onTap: _pickPickupDate,
                  ),
                  const SizedBox(height: 16),
                  ShipFormField(
                    placeholder: 'Internal Reference ID',
                    controller: _referenceController,
                    onChanged: _flow.updateReferenceId,
                  ),
                  const SizedBox(height: 16),
                  ShipFormField(
                    placeholder: 'Item Name & Description',
                    height: 100,
                    controller: _descriptionController,
                    onChanged: _flow.updateItemDescription,
                  ),
                  const SizedBox(height: 16),
                  ShipFormField(
                    placeholder: 'More Pickup Details',
                    value: hasPickupDetails ? _flow.pickupDetails : null,
                    trailing: const Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onTap: _showPickupDetailsDialog,
                  ),
                  const SizedBox(height: 24),
                  ...mockShipAddons.map(
                    (addon) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ShipAddonRow(
                        addon: addon,
                        isSelected: _flow.addonSelection[addon.id] ?? false,
                        onChanged: (selected) => _toggleAddon(addon.id, selected),
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