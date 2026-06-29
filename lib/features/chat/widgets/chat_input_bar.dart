import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Message input row — Figma 516:6548.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.black2,
              borderRadius: BorderRadius.circular(AppLayout.cardRadius),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(AppLayout.cardRadius),
              ),
              child: Text(
                'Type something...',
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white60,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppLayout.cardRadius),
            ),
            child: const Icon(
              Icons.send_outlined,
              color: AppColors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}