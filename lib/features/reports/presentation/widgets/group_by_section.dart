import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class GroupBySection extends StatelessWidget {
  const GroupBySection({
    required this.groupBy,
    required this.onChanged,
    super.key,
  });
  final PlacementGroupBy groupBy;
  final ValueChanged<PlacementGroupBy?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            l10n.groupBy,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          DropdownButton<PlacementGroupBy>(
            value: groupBy,
            borderRadius: BorderRadius.circular(12),
            dropdownColor: colorScheme.surface,
            onChanged: onChanged,
            items: [
              DropdownMenuItem(
                value: PlacementGroupBy.day,
                child: Text(l10n.day),
              ),
              DropdownMenuItem(
                value: PlacementGroupBy.week,
                child: Text(l10n.week),
              ),
              DropdownMenuItem(
                value: PlacementGroupBy.month,
                child: Text(l10n.month),
              ),
              DropdownMenuItem(
                value: PlacementGroupBy.officer,
                child: Text(l10n.officer),
              ),
              DropdownMenuItem(
                value: PlacementGroupBy.branch,
                child: Text(l10n.branch),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
