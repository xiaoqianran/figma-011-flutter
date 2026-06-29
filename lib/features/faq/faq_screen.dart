import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/features/faq/models/faq_item.dart';
import 'package:figma_011/features/faq/widgets/faq_filter_chips.dart';

/// FAQ screen — Figma 516:5503 / 516:5563.
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final _searchController = TextEditingController();
  FaqCategory _category = FaqCategory.delivery;
  String? _expandedQuestion;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FaqItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();
    var items = mockFaqItems.where((item) => item.category == _category);

    if (query.isNotEmpty) {
      items = items.where(
        (item) =>
            item.question.toLowerCase().contains(query) ||
            item.answer.toLowerCase().contains(query),
      );
    }

    final result = items.toList();
    return result.isEmpty && query.isEmpty ? mockFaqItems : result;
  }

  @override
  Widget build(BuildContext context) {
    final List<FaqItem> items = _filteredItems;

    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _FaqAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.black2,
                      borderRadius:
                          BorderRadius.circular(AppLayout.cardRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          size: 18,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {
                              _expandedQuestion = null;
                            }),
                            style: AppTextStyles.dmSans(
                              fontSize: 12,
                              height: 22,
                              color: AppColors.white,
                            ),
                            cursorColor: AppColors.primary,
                            decoration: InputDecoration(
                              hintText: 'Search anything...',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FaqFilterChips(
                    selected: _category,
                    onSelected: (category) {
                      setState(() {
                        _category = category;
                        _expandedQuestion = null;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Top Question',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (items.isEmpty)
                    Text(
                      'No questions found.',
                      style: AppTextStyles.dmSans(
                        fontSize: 14,
                        height: 24,
                        color: AppColors.white60,
                      ),
                    )
                  else
                    ...items.map(
                      (item) => _FaqTile(
                        item: item,
                        isExpanded: _expandedQuestion == item.question,
                        onTap: () {
                          setState(() {
                            _expandedQuestion =
                                _expandedQuestion == item.question
                                    ? null
                                    : item.question;
                          });
                        },
                      ),
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

class _FaqAppBar extends StatelessWidget {
  const _FaqAppBar();

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
            'FAQ',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.item,
    required this.isExpanded,
    required this.onTap,
  });

  final FaqItem item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.question,
              style: AppTextStyles.merriweatherBold(
                fontSize: 16,
                height: 26,
                color: AppColors.white,
              ),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                item.answer,
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: AppColors.white60,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}