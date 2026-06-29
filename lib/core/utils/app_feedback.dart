import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';

/// Shows a styled snack bar for user feedback.
void showAppSnackBar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.primary : AppColors.black2,
        behavior: SnackBarBehavior.floating,
      ),
    );
}