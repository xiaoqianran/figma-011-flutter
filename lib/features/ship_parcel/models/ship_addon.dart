/// Optional add-on for ship parcel — Figma 516:4297 / 516:4304.
class ShipAddon {
  const ShipAddon({
    required this.id,
    required this.label,
    required this.price,
    this.defaultSelected = false,
  });

  final String id;
  final String label;
  final double price;
  final bool defaultSelected;
}

const List<ShipAddon> mockShipAddons = [
  ShipAddon(
    id: 'extra-cover',
    label: 'Extra Cover for Damage',
    price: 3.00,
  ),
  ShipAddon(
    id: 'home-delivery',
    label: 'Home Delivery',
    price: 5.00,
    defaultSelected: true,
  ),
];

const double mockOrderAmount = 48.00;