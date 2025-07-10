import 'package:biz_scope/features/reports/presentation/utils/placement_utils.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({
    required this.order,
    required this.onChanged,
    super.key,
  });
  final PlacementOrder order;
  final ValueChanged<PlacementOrder> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SegmentedButton<PlacementOrder>(
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          selectedBackgroundColor: colorScheme.primary.withOpacity(0.13),
          foregroundColor: colorScheme.primary,
          selectedForegroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          textStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        segments: [
          ButtonSegment(
            value: PlacementOrder.fecha,
            label: Text(l10n.date),
          ),
          ButtonSegment(
            value: PlacementOrder.montoDesc,
            label: Text(
              l10n.amountDesc,
            ),
          ),
          ButtonSegment(
            value: PlacementOrder.montoAsc,
            label: Text(
              l10n.amountAsc,
            ),
          ),
        ],
        selected: <PlacementOrder>{order},
        onSelectionChanged: (s) {
          if (s.isNotEmpty) onChanged(s.first);
        },
      ),
    );
  }
}
