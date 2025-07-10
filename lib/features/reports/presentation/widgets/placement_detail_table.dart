import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/features/reports/presentation/utils/placement_utils.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlacementDetailTable extends StatelessWidget {
  const PlacementDetailTable({
    required this.grouped,
    required this.groupBy,
    super.key,
  });
  final Map<String, double> grouped;
  final PlacementGroupBy groupBy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final moneyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    );

    final labels = grouped.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Text(
          '${l10n.placementDetail} (${labels.length} ${groupLabel(groupBy, context).toLowerCase()}s)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              color: colorScheme.surface,
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: WidgetStateProperty.all(
                  colorScheme.surfaceContainerHighest,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      groupLabel(groupBy, context),
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      l10n.totalAmount,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
                rows: List.generate(labels.length, (index) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          labels[index],
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      DataCell(
                        Text(
                          moneyFormat.format(grouped[labels[index]]),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
