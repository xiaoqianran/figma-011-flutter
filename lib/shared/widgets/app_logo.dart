import 'package:flutter/material.dart';

/// Fast Courier brand logo exported from Figma Logo/Color component.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 144,
    this.height = 92,
  });

  final double width;
  final double height;

  static const String assetPath = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}