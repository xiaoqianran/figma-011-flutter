import 'package:flutter/material.dart';

import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/chat/models/chat_conversation.dart';

/// One row in the Messages list — Figma 516:6479.
class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.conversation,
    this.onTap,
  });

  final ChatConversation conversation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(name: conversation.name),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.name,
                          style: AppTextStyles.merriweatherBold(
                            fontSize: 16,
                            height: 26,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        conversation.timestamp,
                        style: AppTextStyles.dmSans(
                          fontSize: 12,
                          height: 22,
                          color: AppColors.white60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: AppTextStyles.dmSans(
                            fontSize: 14,
                            height: 24,
                            color: AppColors.white60,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        _UnreadBadge(count: conversation.unreadCount),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.black2,
      child: Text(
        initial,
        style: AppTextStyles.merriweatherBold(
          fontSize: 18,
          height: 24,
        ),
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: AppTextStyles.dmSans(
          fontSize: 14,
          height: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}