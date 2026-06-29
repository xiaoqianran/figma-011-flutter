import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';

enum SocialProvider { google, facebook, twitter, apple }

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.provider,
    this.onPressed,
  });

  final SocialProvider provider;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.gray1,
      shape: const CircleBorder(
        side: BorderSide(color: Color(0xFF979797)),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(child: _icon()),
        ),
      ),
    );
  }

  Widget _icon() {
    switch (provider) {
      case SocialProvider.google:
        return const Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        );
      case SocialProvider.facebook:
        return const Text(
          'f',
          style: TextStyle(
            color: Color(0xFF3C5A9A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        );
      case SocialProvider.twitter:
        return const Icon(
          Icons.alternate_email,
          color: Color(0xFF2DAAE1),
          size: 18,
        );
      case SocialProvider.apple:
        return const Icon(
          Icons.apple,
          color: AppColors.black1,
          size: 20,
        );
    }
  }
}