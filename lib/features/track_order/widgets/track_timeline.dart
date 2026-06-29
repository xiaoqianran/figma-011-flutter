import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/track_order/models/track_event.dart';

/// Vertical tracking timeline — Figma 516:2596.
class TrackTimeline extends StatelessWidget {
  const TrackTimeline({
    super.key,
    required this.events,
  });

  final List<TrackEvent> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < events.length; i++)
          _TimelineItem(
            event: events[i],
            isLast: i == events.length - 1,
            lineColor: _lineColor(events, i),
          ),
      ],
    );
  }

  Color _lineColor(List<TrackEvent> items, int index) {
    if (index >= items.length - 1) {
      return Colors.transparent;
    }
    final TrackEvent next = items[index + 1];
    return next.status == TrackEventStatus.pending
        ? AppColors.gray1
        : AppColors.primary;
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.event,
    required this.isLast,
    required this.lineColor,
  });

  final TrackEvent event;
  final bool isLast;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                _TimelineDot(status: event.status),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.date,
                        style: AppTextStyles.merriweatherBold(
                          fontSize: 14,
                          height: 24,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 38),
                      Expanded(
                        child: Text(
                          event.title,
                          style: AppTextStyles.merriweatherBold(
                            fontSize: 14,
                            height: 24,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.time,
                        style: AppTextStyles.dmSans(
                          fontSize: 12,
                          height: 22,
                          color: AppColors.white60,
                        ),
                      ),
                      const SizedBox(width: 58),
                      Expanded(
                        child: Text(
                          event.address,
                          style: AppTextStyles.dmSans(
                            fontSize: 12,
                            height: 22,
                            color: AppColors.white60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({required this.status});

  final TrackEventStatus status;

  @override
  Widget build(BuildContext context) {
    final Color outerColor = switch (status) {
      TrackEventStatus.pending => AppColors.primary20,
      TrackEventStatus.completed => AppColors.primary,
      TrackEventStatus.active => AppColors.primary,
    };

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: outerColor,
      ),
      child: Center(
        child: Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black2,
          ),
        ),
      ),
    );
  }
}