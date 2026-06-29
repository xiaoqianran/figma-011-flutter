import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/router/app_navigation.dart';
import 'package:figma_011/core/router/app_routes.dart';
import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/core/utils/app_feedback.dart';
import 'package:figma_011/features/chat/widgets/chat_list_tile.dart';
import 'package:figma_011/shared/widgets/app_bottom_nav_bar.dart';

/// Messages list — Figma 516:6460.
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTab = appTabFromLocation(GoRouterState.of(context).uri.path);

    return Scaffold(
      backgroundColor: AppColors.black1,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ChatAppBar(
              onMore: () => showAppSnackBar(
                context,
                message: 'More options coming soon',
              ),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: AppState.instance,
                builder: (context, _) {
                  final conversations = AppState.instance.conversations;
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                    itemCount: conversations.length,
                    separatorBuilder: (_, _) => const Divider(
                      color: AppColors.white30,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return ChatListTile(
                        conversation: conversation,
                        onTap: () => context.push(
                          AppRoutes.chatDetail(conversation.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: currentTab,
        onTabSelected: (tab) => navigateToAppTab(context, tab),
        onFabTap: () => context.push(AppRoutes.servicesMenu),
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget {
  const _ChatAppBar({required this.onMore});

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
              onPressed: () => context.go(AppRoutes.home),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Messages',
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