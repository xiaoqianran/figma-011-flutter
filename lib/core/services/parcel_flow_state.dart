import 'package:flutter/foundation.dart';

import 'package:figma_011/features/calculate_parcel/models/package_size.dart';
import 'package:figma_011/features/ship_parcel/models/ship_addon.dart';

/// Shared state for calculate / ship parcel flows.
class ParcelFlowState extends ChangeNotifier {
  ParcelFlowState._();

  static final ParcelFlowState instance = ParcelFlowState._();

  String from = 'Gouripur, Daudkandi';
  String to = 'Tejgaon, Dhaka';
  String selectedPackageId = mockPackageSizes.first.id;
  String packagingType = 'Box';
  int packageCount = 3;
  double weightKg = 5;
  int extraPackagesAdded = 0;

  String pickupDate = '24 Jun, 16:32';
  String referenceId = '';
  String itemDescription = '';
  String pickupDetails = '';

  late Map<String, bool> addonSelection = {
    for (final ShipAddon addon in mockShipAddons)
      addon.id: addon.defaultSelected,
  };

  String promoCode = '';
  double promoDiscount = 0;
  double? lastCalculatedPrice;
  String? selectedCourierId;

  static const List<String> packagingTypes = ['Box', 'Envelope', 'Tube'];

  PackageSize get selectedPackage => mockPackageSizes.firstWhere(
        (p) => p.id == selectedPackageId,
        orElse: () => mockPackageSizes.first,
      );

  double calculatePrice() {
    final base = selectedPackage.price + 40;
    lastCalculatedPrice = base;
    notifyListeners();
    return base;
  }

  double get orderAmount {
    var amount = lastCalculatedPrice ?? mockOrderAmount;
    for (final addon in mockShipAddons) {
      if (addonSelection[addon.id] == true) {
        amount += addon.price;
      }
    }
    amount += extraPackagesAdded * 5;
    return amount;
  }

  static const double homeDeliveryFee = 5;

  double get total {
    final subtotal = orderAmount + homeDeliveryFee - promoDiscount;
    return subtotal < 0 ? 0 : subtotal;
  }

  bool applyPromoCode(String code) {
    final normalized = code.trim().toUpperCase();
    if (normalized == 'FAST10') {
      promoCode = normalized;
      promoDiscount = 10;
      notifyListeners();
      return true;
    }
    if (normalized == 'SAVE5') {
      promoCode = normalized;
      promoDiscount = 5;
      notifyListeners();
      return true;
    }
    return false;
  }

  void resetAfterOrder() {
    extraPackagesAdded = 0;
    promoCode = '';
    promoDiscount = 0;
    lastCalculatedPrice = null;
    notifyListeners();
  }

  void updateRoute({String? from, String? to}) {
    if (from != null) {
      this.from = from;
    }
    if (to != null) {
      this.to = to;
    }
    notifyListeners();
  }

  void selectPackage(String id) {
    selectedPackageId = id;
    notifyListeners();
  }

  void selectPackagingType(String type) {
    packagingType = type;
    notifyListeners();
  }

  void updatePackageCount(int count) {
    packageCount = count.clamp(1, 10);
    notifyListeners();
  }

  void updateWeightKg(double kg) {
    weightKg = kg.clamp(1, 10).toDouble();
    notifyListeners();
  }

  void addExtraPackage() {
    extraPackagesAdded += 1;
    notifyListeners();
  }

  void updatePickupDate(String date) {
    pickupDate = date;
    notifyListeners();
  }

  void updateReferenceId(String value) {
    referenceId = value;
    notifyListeners();
  }

  void updateItemDescription(String value) {
    itemDescription = value;
    notifyListeners();
  }

  void updatePickupDetails(String value) {
    pickupDetails = value;
    notifyListeners();
  }

  void updateAddon(String id, bool selected) {
    addonSelection[id] = selected;
    notifyListeners();
  }

  void selectCourier(String id) {
    selectedCourierId = id;
    notifyListeners();
  }
}