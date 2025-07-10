part of 'news_carousel.dart';

class NewsCard extends StatelessWidget {
  final BranchNews item;
  const NewsCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = item.isPositive;
    final List<Color> gradientColors = isPositive
        ? [Colors.green.shade600, Colors.teal.shade300]
        : [Colors.red.shade600, Colors.orange.shade300];

    final mainColor = isPositive ? Colors.green.shade600 : Colors.red.shade600;

    final growthText = item.growth == 0
        ? ''
        : '${item.growth > 0 ? '+' : ''}${(item.growth * 100).abs().toStringAsFixed(0)}%';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
      child: Card(
        elevation: 16,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Fondo degradado
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: (isPositive ? Colors.green : Colors.red).withOpacity(
                      0.10,
                    ),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 19),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icono
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: mainColor.withOpacity(0.18),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(13),
                    child: Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: mainColor,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Texto y badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 13,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.86),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                item.branch,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: mainColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                            if (item.tag != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.tag!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 11.5,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.74),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 12,
                          ),
                          child: Text(
                            item.message,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: mainColor.withOpacity(0.92),
                              fontWeight: FontWeight.w500,
                              height: 1.18,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (growthText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Row(
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 370),
                                  transitionBuilder: (child, anim) =>
                                      ScaleTransition(
                                        scale: anim,
                                        child: child,
                                      ),
                                  child: Icon(
                                    isPositive
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    key: ValueKey(isPositive),
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 280),
                                  child: Text(
                                    growthText,
                                    key: ValueKey(growthText),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.5,
                                      shadows: [
                                        Shadow(
                                          color: mainColor.withOpacity(0.17),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
