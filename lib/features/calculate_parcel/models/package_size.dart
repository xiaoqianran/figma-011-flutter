/// Parcel size option — Figma Mesurement cards 516:3928.
class PackageSize {
  const PackageSize({
    required this.id,
    required this.name,
    required this.price,
    required this.maxWeight,
    required this.maxLength,
  });

  final String id;
  final String name;
  final double price;
  final String maxWeight;
  final String maxLength;
}

/// Mock package sizes from Figma 516:2931.
const List<PackageSize> mockPackageSizes = [
  PackageSize(
    id: 'small-light',
    name: 'Small',
    price: 8.00,
    maxWeight: '0-5 kg',
    maxLength: '33 cm',
  ),
  PackageSize(
    id: 'small-medium',
    name: 'Small',
    price: 8.00,
    maxWeight: '5-9 kg',
    maxLength: '33 cm',
  ),
];

/// Suggested result from calculation — Figma 516:4110.
const PackageSize mockSuggestedPackage = PackageSize(
  id: 'suggested',
  name: 'Small',
  price: 48.00,
  maxWeight: '0-5 kg',
  maxLength: '33 cm',
);