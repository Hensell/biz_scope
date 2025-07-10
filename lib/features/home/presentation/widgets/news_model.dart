part of 'news_carousel.dart';

class BranchNews {
  final String branch;
  final String message;
  final double growth;
  final String? tag;
  final bool positive;

  const BranchNews({
    required this.branch,
    required this.message,
    required this.growth,
    this.tag,
    this.positive = false,
  });

  bool get isPositive => positive || growth > 0;
}
