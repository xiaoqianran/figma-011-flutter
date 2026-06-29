/// Delivery status for shipment cards.
enum ShipmentStatus {
  pending,
  completed;

  String get label => switch (this) {
        ShipmentStatus.pending => 'Pending',
        ShipmentStatus.completed => 'Completed',
      };
}

/// Shipment row shown on Home and History screens.
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
  final ShipmentStatus status;
  final String fromLocation;
  final String fromTime;
  final String toLocation;
  final String toTime;
}

const Shipment _sampleShipment = Shipment(
  trackingNumber: '#124 784 8754',
  status: ShipmentStatus.pending,
  fromLocation: 'Amsterdam, Netherlands',
  fromTime: '24 Jun, 16:32',
  toLocation: 'New York, USA',
  toTime: '30 Jun, 08:41',
);

/// Mock data for Home — Figma 515:3686 (Pending only).
const List<Shipment> mockHomeShipments = [
  _sampleShipment,
  _sampleShipment,
];

/// Mock data for History — Figma 515:2618 (All tab).
const List<Shipment> mockHistoryShipments = [
  Shipment(
    trackingNumber: '#124 784 8754',
    status: ShipmentStatus.completed,
    fromLocation: 'Amsterdam, Netherlands',
    fromTime: '24 Jun, 16:32',
    toLocation: 'New York, USA',
    toTime: '30 Jun, 08:41',
  ),
  _sampleShipment,
  Shipment(
    trackingNumber: '#124 784 8754',
    status: ShipmentStatus.completed,
    fromLocation: 'Amsterdam, Netherlands',
    fromTime: '24 Jun, 16:32',
    toLocation: 'New York, USA',
    toTime: '30 Jun, 08:41',
  ),
];