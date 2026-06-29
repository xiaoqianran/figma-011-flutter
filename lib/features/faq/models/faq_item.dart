/// FAQ category tabs — Figma 516:5510.
enum FaqCategory {
  delivery,
  order,
  receive,
  courrier;

  String get label => switch (this) {
        FaqCategory.delivery => 'Delivery',
        FaqCategory.order => 'Order',
        FaqCategory.receive => 'Receive',
        FaqCategory.courrier => 'Courrier',
      };
}

/// FAQ question item — Figma 516:5544.
class FaqItem {
  const FaqItem({
    required this.question,
    required this.answer,
    this.category = FaqCategory.delivery,
  });

  final String question;
  final String answer;
  final FaqCategory category;
}

const List<FaqItem> mockFaqItems = [
  FaqItem(
    question: 'How to contact the seller?',
    answer:
        'Rapidiously disseminate strategic content via virtual mindshare. '
        'Intrinsicly syndicate cost effective resources rather than '
        'visionary channels.',
  ),
  FaqItem(
    question: 'Can I change my order?',
    answer: 'You can change your order before it is picked up by courier.',
    category: FaqCategory.order,
  ),
  FaqItem(
    question: 'Can I cancel my order?',
    answer: 'Orders can be cancelled within 30 minutes of placement.',
    category: FaqCategory.order,
  ),
  FaqItem(
    question: 'What is your return policy?',
    answer: 'Returns are accepted within 7 days for eligible items.',
    category: FaqCategory.receive,
  ),
  FaqItem(
    question: 'Have any express delivery services?',
    answer: 'Yes, express delivery is available in select areas.',
    category: FaqCategory.delivery,
  ),
];