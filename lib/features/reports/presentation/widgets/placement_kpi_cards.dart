import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class PlacementKpiCards extends StatelessWidget {
  const PlacementKpiCards({required this.kpis, super.key});
  final Map<String, String> kpis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Wrap(
        spacing: 13,
        runSpacing: 13,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          _KpiTileCard(label: l10n.lastDay, value: kpis[l10n.day] ?? '---'),
          _KpiTileCard(label: l10n.lastWeek, value: kpis[l10n.week] ?? '---'),
          _KpiTileCard(label: l10n.lastMonth, value: kpis[l10n.month] ?? '---'),
          _KpiTileCard(label: l10n.lastYear, value: kpis[l10n.year] ?? '---'),
        ],
      ),
    );
  }
}

class _KpiTileCard extends StatelessWidget {
  const _KpiTileCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(isDark ? 0.14 : 0.13),
            blurRadius: 18,
            spreadRadius: 0.6,
            offset: const Offset(0, 0),
          ),
        ],
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.13),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.7,
                color: colorScheme.primary,
                letterSpacing: 0.04,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 7),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 320),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Text(
                value,
                key: ValueKey(value),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.7,
                  color: colorScheme.primary,
                  letterSpacing: 0.12,
                  shadows: [
                    Shadow(
                      color: colorScheme.primary.withOpacity(0.08),
                      blurRadius: 7,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
