import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/chat/models/chat_message.dart';

/// Chat bubble — Figma 516:6534 / 516:6539.
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.senderName,
  });

  final ChatMessage message;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    final bool isFromMe = message.isFromMe;

    return Padding(
      padding: EdgeInsets.only(
        top: message.isFirstInGroup ? 16 : 8,
        left: isFromMe ? 56 : 0,
        right: isFromMe ? 0 : 56,
      ),
      child: Row(
        mainAxisAlignment:
            isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isFromMe && message.isFirstInGroup) ...[
            _SmallAvatar(name: senderName),
            const SizedBox(width: 16),
          ] else if (!isFromMe) ...[
            const SizedBox(width: 48),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppLayout.cardRadius),
              ),
              child: Text(
                message.text,
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: isFromMe ? AppColors.white : AppColors.black1,
                ),
              ),
            ),
          ),
          if (isFromMe && message.isFirstInGroup) ...[
            const SizedBox(width: 16),
            _SmallAvatar(name: 'Me'),
          ] else if (isFromMe) ...[
            const SizedBox(width: 48),
          ],
        ],
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  const _SmallAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.black2,
      child: Text(
        initial,
        style: AppTextStyles.dmSans(
          fontSize: 12,
          height: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}