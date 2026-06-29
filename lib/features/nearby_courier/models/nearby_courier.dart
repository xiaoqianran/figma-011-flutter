/// Nearby courier location — Figma Courier Service/Large 515:4018.
class NearbyCourier {
  const NearbyCourier({
    required this.id,
    required this.name,
    required this.address,
    required this.isOpen,
    required this.rating,
    required this.hours,
    this.isVisited = false,
  });

  final String id;
  final String name;
  final String address;
  final bool isOpen;
  final double rating;
  final String hours;
  final bool isVisited;

  String get statusLabel => isOpen ? 'Open' : 'Closed';
}

/// Mock nearby courier locations from Figma 515:4018.
const List<NearbyCourier> mockNearbyCouriers = [
  NearbyCourier(
    id: 'ups',
    name: 'United Parcel Service',
    address: 'W Market Rd, Gouripur 3517',
    isOpen: true,
    rating: 4.0,
    hours: 'Open : 9am - 8pm',
    isVisited: true,
  ),
  NearbyCourier(
    id: 'fast-hub',
    name: 'Fast Delivery Hub',
    address: 'W Market Rd, Gouripur 3517',
    isOpen: true,
    rating: 4.8,
    hours: 'Open : 9am - 8pm',
  ),
  NearbyCourier(
    id: 'fox',
    name: 'Fox Parcel',
    address: 'W Market Rd, Gouripur 3517',
    isOpen: false,
    rating: 3.9,
    hours: 'Open : 9am - 8pm',
    isVisited: true,
  ),
];