import 'package:figma_011/features/track_order/models/track_event.dart';

/// Normalizes tracking IDs by stripping spaces and hash symbols.
String normalizeTrackingId(String id) {
  return id.replaceAll(RegExp(r'[#\s]'), '');
}

/// Demo tracking lookup — returns events for known IDs.
TrackingLookupResult lookupTracking(String rawId) {
  final id = normalizeTrackingId(rawId);
  if (id.isEmpty) {
    return const TrackingLookupResult.notFound();
  }
  if (id == normalizeTrackingId(mockShippingId) ||
      id == '1247848754') {
    return TrackingLookupResult.found(
      shippingId: mockShippingId,
      events: mockTrackEvents,
    );
  }
  return const TrackingLookupResult.notFound();
}

/// Result of a tracking number search.
class TrackingLookupResult {
  const TrackingLookupResult.found({
    required this.shippingId,
    required this.events,
  }) : notFound = false;

  const TrackingLookupResult.notFound()
      : shippingId = '',
        events = const [],
        notFound = true;

  final bool notFound;
  final String shippingId;
  final List<TrackEvent> events;
}