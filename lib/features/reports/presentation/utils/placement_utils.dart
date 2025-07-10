import 'package:biz_scope/features/reports/data/models/placement.dart';
import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PlacementOrder { fecha, montoDesc, montoAsc }

List<String> getBranches(List<Placement> placements, String allBranchesLabel) {
  final branches = placements.map((p) => p.branch).toSet().toList()..sort();
  if (!branches.contains(allBranchesLabel)) {
    branches.insert(0, allBranchesLabel);
  }
  return branches;
}

List<Placement> filterByBranch(
  List<Placement> placements,
  String? branch,
  String allBranchesLabel,
) {
  if (branch == null || branch == allBranchesLabel) return placements;
  return placements.where((p) => p.branch == branch).toList();
}

Map<String, double> groupPlacements(
  List<Placement> placements,
  PlacementGroupBy groupBy,
  PlacementOrder order,
  BuildContext context,
) {
  final l10n = AppLocalizations.of(context);
  final grouped = <String, double>{};
  for (final p in placements) {
    String key;
    switch (groupBy) {
      case PlacementGroupBy.day:
        key = DateFormat('dd/MM').format(p.date);
      case PlacementGroupBy.week:
        final week = ((p.date.day - 1) ~/ 7) + 1;
        key =
            '${l10n.weekShort} $week/${p.date.month.toString().padLeft(2, '0')}';
      case PlacementGroupBy.month:
        key = '${p.date.month.toString().padLeft(2, '0')}/${p.date.year}';
      case PlacementGroupBy.officer:
        key = p.officer;
      case PlacementGroupBy.branch:
        key = p.branch;
    }
    grouped.update(key, (v) => v + p.amount, ifAbsent: () => p.amount);
  }

  final entries = grouped.entries.toList();
  switch (order) {
    case PlacementOrder.fecha:
      entries.sort((a, b) => a.key.compareTo(b.key));
    case PlacementOrder.montoDesc:
      entries.sort((a, b) => b.value.compareTo(a.value));
    case PlacementOrder.montoAsc:
      entries.sort((a, b) => a.value.compareTo(b.value));
  }
  return Map.fromEntries(entries);
}

Map<String, String> getTopOfficerKpis(
  List<Placement> placements,
  BuildContext context,
) {
  final l10n = AppLocalizations.of(context)!;
  if (placements.isEmpty) {
    return {
      l10n.day: '---',
      l10n.week: '---',
      l10n.month: '---',
      l10n.year: '---',
    };
  }
  final moneyFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  final dates = placements.map((p) => p.date).toList()..sort();
  final lastDay = dates.last;
  final kpiDay = placements.where(
    (p) =>
        p.date.year == lastDay.year &&
        p.date.month == lastDay.month &&
        p.date.day == lastDay.day,
  );

  final weeks = placements.map(
    (p) => DateTime(p.date.year, p.date.month, (p.date.day - 1) ~/ 7 + 1),
  );
  final lastWeek = weeks.reduce((a, b) => a.isAfter(b) ? a : b);
  final kpiWeek = placements.where(
    (p) =>
        p.date.year == lastWeek.year &&
        p.date.month == lastWeek.month &&
        ((p.date.day - 1) ~/ 7 + 1) == ((lastWeek.day - 1) ~/ 7 + 1),
  );

  final months = placements.map((p) => DateTime(p.date.year, p.date.month));
  final lastMonth = months.reduce((a, b) => a.isAfter(b) ? a : b);
  final kpiMonth = placements.where(
    (p) => p.date.year == lastMonth.year && p.date.month == lastMonth.month,
  );

  final years = placements.map((p) => p.date.year);
  final lastYear = years.reduce((a, b) => a > b ? a : b);
  final kpiYear = placements.where((p) => p.date.year == lastYear);

  String topOfficer(Iterable<Placement> list) {
    if (list.isEmpty) return '---';
    final grouped = <String, double>{};
    for (final p in list) {
      grouped.update(p.officer, (v) => v + p.amount, ifAbsent: () => p.amount);
    }
    final sorted = grouped.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return '${sorted.first.key} (${moneyFormat.format(sorted.first.value)})';
  }

  return {
    l10n.day: topOfficer(kpiDay),
    l10n.week: topOfficer(kpiWeek),
    l10n.month: topOfficer(kpiMonth),
    l10n.year: topOfficer(kpiYear),
  };
}

String groupLabel(PlacementGroupBy groupBy, BuildContext context) {
  final l10n = AppLocalizations.of(context);
  switch (groupBy) {
    case PlacementGroupBy.day:
      return l10n.day;
    case PlacementGroupBy.week:
      return l10n.week;
    case PlacementGroupBy.month:
      return l10n.month;
    case PlacementGroupBy.officer:
      return l10n.officer;
    case PlacementGroupBy.branch:
      return l10n.branch;
  }
}

double getInterval(Iterable<double> values) {
  final max = values.isEmpty ? 1000 : values.reduce((a, b) => a > b ? a : b);
  final raw = max / 5;
  final interval = (raw / 500).ceil() * 500;
  return interval == 0 ? 500 : interval.toDouble();
}

Color withValues(Color c, {required double alpha}) {
  assert(alpha >= 0 && alpha <= 1.0);
  return c.withAlpha((alpha * 255).round());
}
