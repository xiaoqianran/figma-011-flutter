/// Status of a single tracking timeline step.
enum TrackEventStatus {
  completed,
  active,
  pending,
}

/// One step in the order tracking timeline — Figma 516:2507.
class TrackEvent {
  const TrackEvent({
    required this.date,
    required this.time,
    required this.title,
    required this.address,
    required this.status,
  });

  final String date;
  final String time;
  final String title;
  final String address;
  final TrackEventStatus status;
}

/// Mock tracking data from Figma 516:2507.
const String mockShippingId = '97847548956';

const List<TrackEvent> mockTrackEvents = [
  TrackEvent(
    date: 'May 21',
    time: '12:50',
    title: 'Package has been received',
    address: 'W Market Rd, Gouripur 3517',
    status: TrackEventStatus.active,
  ),
  TrackEvent(
    date: 'May 20',
    time: '14:00',
    title: 'Arrived at destination area',
    address: 'W Market Rd, Gouripur 3517',
    status: TrackEventStatus.completed,
  ),
  TrackEvent(
    date: 'May 19',
    time: '13:00',
    title: 'Accept by Wedx',
    address: 'W Market Rd, Gouripur 3517',
    status: TrackEventStatus.pending,
  ),
];