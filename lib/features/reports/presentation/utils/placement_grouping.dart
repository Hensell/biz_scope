import 'package:biz_scope/features/reports/data/models/placement.dart';

Map<String, double> groupPlacementsByMonth(List<Placement> placements) {
  final grouped = <String, double>{};
  for (var p in placements) {
    final key = '${p.date.year}-${p.date.month.toString().padLeft(2, '0')}';
    grouped.update(key, (v) => v + p.amount, ifAbsent: () => p.amount);
  }
  return grouped;
}
