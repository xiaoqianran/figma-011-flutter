import 'package:flutter/material.dart';

import 'package:fast_courier_app/core/theme/app_colors.dart';

/// Stylized map background — Figma 515:4061 map view.
class NearbyMapPlaceholder extends StatelessWidget {
  const NearbyMapPlaceholder({super.key});

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
          Positioned(
            left: 80,
            top: 120,
            child: _ZoneCircle(
              size: 180,
              color: AppColors.primary20,
            ),
          ),
          Positioned(
            right: 40,
            top: 200,
            child: _ZoneCircle(
              size: 120,
              color: AppColors.primary20,
            ),
          ),
          Positioned(
            left: 140,
            top: 280,
            child: _ZoneCircle(
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          const Positioned(
            left: 168,
            top: 220,
            child: Icon(
              Icons.location_on,
              size: 32,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneCircle extends StatelessWidget {
  const _ZoneCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.5),
          width: 1.5,
        ),
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