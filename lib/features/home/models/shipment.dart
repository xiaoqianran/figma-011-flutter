/// Shipment row shown on the Home / History screens.
class Shipment {
  const Shipment({
    required this.trackingNumber,
    required this.status,
    required this.fromLocation,
    required this.fromTime,
    required this.toLocation,
    required this.toTime,
  });

  final String trackingNumber;
  final String status;
  final String fromLocation;
  final String fromTime;
  final String toLocation;
  final String toTime;
}

/// Mock shipment history for the Home screen (Figma 515:3686).
const List<Shipment> mockShipments = [
  Shipment(
    trackingNumber: '#124 784 8754',
    status: 'Pending',
    fromLocation: 'Amsterdam, Netherlands',
    fromTime: '24 Jun, 16:32',
    toLocation: 'New York, USA',
    toTime: '30 Jun, 08:41',
  ),
  Shipment(
    trackingNumber: '#124 784 8754',
    status: 'Pending',
    fromLocation: 'Amsterdam, Netherlands',
    fromTime: '24 Jun, 16:32',
    toLocation: 'New York, USA',
    toTime: '30 Jun, 08:41',
  ),
];