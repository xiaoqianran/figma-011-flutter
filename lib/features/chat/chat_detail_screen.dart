import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/chat/widgets/chat_input_bar.dart';
import 'package:figma_011/features/chat/widgets/chat_message_bubble.dart';

/// Single conversation view — Figma 516:6512.
class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.conversationId,
  });

  final String conversationId;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppState.instance.markConversationRead(widget.conversationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final conversation =
            AppState.instance.conversationById(widget.conversationId);

        if (conversation == null) {
          return Scaffold(
            backgroundColor: AppColors.black1,
            body: SafeArea(
              child: Center(
                child: Text(
                  'Conversation not found',
                  style: AppTextStyles.dmSans(fontSize: 14, height: 24),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.black1,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ChatDetailAppBar(
                  name: conversation.name,
                  onMore: () => showAppSnackBar(
                    context,
                    message: 'More options coming soon',
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    children: [
                      Center(
                        child: Text(
                          conversation.timestamp,
                          style: AppTextStyles.dmSans(
                            fontSize: 12,
                            height: 22,
                            color: AppColors.white60,
                          ),
                        ),
                      ),
                      ...conversation.messages.map(
                        (message) => ChatMessageBubble(
                          message: message,
                          senderName: conversation.name,
                        ),
                      ),
                    ],
                  ),
                ),
                ChatInputBar(
                  onSend: (text) => AppState.instance.sendMessage(
                    widget.conversationId,
                    text,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChatDetailAppBar extends StatelessWidget {
  const _ChatDetailAppBar({
    required this.name,
    required this.onMore,
  });

  final String name;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            name,
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onMore,
              icon: const Icon(
                Icons.more_vert,
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