import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Map with route visualization — Figma 516:2518 / 516:2882.
class TrackMapPlaceholder extends StatelessWidget {
  const TrackMapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2A2D35),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _MapGridPainter(),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _RoutePainter(),
            ),
          ),
          const Positioned(
            left: 76,
            top: 130,
            child: _RouteMarker(
              size: 34,
              isDestination: false,
              child: Icon(
                Icons.near_me,
                size: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          const Positioned(
            left: 197,
            top: 100,
            child: _TruckMarker(),
          ),
          const Positioned(
            right: 78,
            top: 38,
            child: _RouteMarker(
              size: 28,
              isDestination: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteMarker extends StatelessWidget {
  const _RouteMarker({
    required this.size,
    this.isDestination = false,
    this.child,
  });

  final double size;
  final bool isDestination;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary20,
      ),
      child: Center(
        child: isDestination
            ? Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              )
            : child,
      ),
    );
  }
}

class _TruckMarker extends StatelessWidget {
  const _TruckMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.local_shipping_outlined,
        size: 16,
        color: AppColors.primary,
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.white30
      ..strokeWidth = 0.5;

    const double spacing = 40;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(93, 147)
      ..quadraticBezierTo(150, 90, 211, 114)
      ..quadraticBezierTo(260, 130, 297, 52);

    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}