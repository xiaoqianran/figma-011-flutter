import 'package:flutter/material.dart';

import 'package:figma_011/core/constants/app_layout.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';

/// Horizontal promo banner carousel — Figma Banner 1/2 (515:2419).
class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  static const double _cardWidth = 280;
  static const double _cardSpacing = 14;

  final PageController _controller = PageController(
    viewportFraction: _cardWidth / AppLayout.designWidth,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _controller,
        itemCount: 2,
        padEnds: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : _cardSpacing / 2,
              right: _cardSpacing / 2,
            ),
            child: const _PromoCard(),
          );
        },
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.promoBg,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/home_promo_card.png',
              width: 150,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get 15%\nCash back',
                  style: AppTextStyles.merriweatherBlack(
                    fontSize: 20,
                    height: 24,
                    color: AppColors.black1,
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    style: AppTextStyles.dmSans(
                      fontSize: 12,
                      height: 22,
                      color: AppColors.black1,
                    ),
                    children: [
                      const TextSpan(text: 'Use the code '),
                      TextSpan(
                        text: '#frd784',
                        style: AppTextStyles.dmSans(
                          fontSize: 12,
                          height: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}