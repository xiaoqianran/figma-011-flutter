import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Message input row — Figma 516:6548.
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.onSend,
    this.onAttach,
  });

  final ValueChanged<String> onSend;
  final VoidCallback? onAttach;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onAttach,
            child: Container(
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
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _send(),
                style: AppTextStyles.dmSans(
                  fontSize: 12,
                  height: 22,
                  color: AppColors.white,
                ),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  hintStyle: AppTextStyles.dmSans(
                    fontSize: 12,
                    height: 22,
                    color: AppColors.white60,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: _send,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}