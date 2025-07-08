import 'package:biz_scope/features/reports/data/models/placement.dart';
import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum _PlacementOrder { fecha, montoDesc, montoAsc }

class PlacementView extends StatefulWidget {
  const PlacementView({super.key});

  @override
  State<PlacementView> createState() => _PlacementViewState();
}

class _PlacementViewState extends State<PlacementView> {
  _PlacementOrder _order = _PlacementOrder.fecha;
  String? _branch; // Filtro actual de branch

  final NumberFormat _moneyFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  List<String> _getBranches(List<Placement> placements) {
    final branches = placements.map((p) => p.branch).toSet().toList();
    branches.sort();
    return branches;
  }

  List<Placement> _filterByBranch(List<Placement> placements) {
    if (_branch == null || _branch == 'Todas') return placements;
    return placements.where((p) => p.branch == _branch).toList();
  }

  Map<String, double> groupPlacements(
    List<Placement> placements,
    PlacementGroupBy groupBy,
  ) {
    final Map<String, double> grouped = {};
    for (var p in placements) {
      String key;
      switch (groupBy) {
        case PlacementGroupBy.day:
          key =
              '${p.date.day.toString().padLeft(2, '0')}/${p.date.month.toString().padLeft(2, '0')}';
          break;
        case PlacementGroupBy.week:
          final week = ((p.date.day - 1) ~/ 7) + 1;
          key = 'W$week/${p.date.month.toString().padLeft(2, '0')}';
          break;
        case PlacementGroupBy.month:
          key = '${p.date.month.toString().padLeft(2, '0')}/${p.date.year}';
          break;
        case PlacementGroupBy.officer:
          key = p.officer;
          break;
        case PlacementGroupBy.branch:
          key = p.branch;
          break;
      }
      grouped.update(key, (v) => v + p.amount, ifAbsent: () => p.amount);
    }

    // Ordenar según lo seleccionado
    List<MapEntry<String, double>> entries = grouped.entries.toList();
    switch (_order) {
      case _PlacementOrder.fecha:
        entries.sort((a, b) => a.key.compareTo(b.key));
        break;
      case _PlacementOrder.montoDesc:
        entries.sort((a, b) => b.value.compareTo(a.value));
        break;
      case _PlacementOrder.montoAsc:
        entries.sort((a, b) => a.value.compareTo(b.value));
        break;
    }
    return Map.fromEntries(entries);
  }

  Map<String, dynamic> _getTopOfficerKpis(List<Placement> placements) {
    if (placements.isEmpty) {
      return {'Día': '---', 'Semana': '---', 'Mes': '---', 'Año': '---'};
    }
    final dates = placements.map((p) => p.date).toList()..sort();
    final lastDay = dates.last;
    final kpiDay = placements.where(
      (p) =>
          p.date.year == lastDay.year &&
          p.date.month == lastDay.month &&
          p.date.day == lastDay.day,
    );

    final weeks = placements.map(
      (p) => DateTime(p.date.year, p.date.month, ((p.date.day - 1) ~/ 7 + 1)),
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
      for (var p in list) {
        grouped.update(
          p.officer,
          (v) => v + p.amount,
          ifAbsent: () => p.amount,
        );
      }
      final sorted = grouped.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return '${sorted.first.key} (${_moneyFormat.format(sorted.first.value)})';
    }

    return {
      'Día': topOfficer(kpiDay),
      'Semana': topOfficer(kpiWeek),
      'Mes': topOfficer(kpiMonth),
      'Año': topOfficer(kpiYear),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Colocaciones'), centerTitle: true),
      body: BlocBuilder<PlacementCubit, PlacementState>(
        builder: (context, state) {
          if (state is PlacementLoading || state is PlacementInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlacementError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is PlacementLoaded) {
            final placements = state.placements;
            final groupBy = state.groupBy;

            if (placements.isEmpty) {
              return const Center(child: Text('No hay colocaciones aún'));
            }

            // BRANCHES y FILTRO
            final branches = _getBranches(placements);
            branches.insert(0, "Todas");
            // Nota: Si agrupas por branch, no filtres por branch
            final filtered = (groupBy == PlacementGroupBy.branch)
                ? placements
                : _filterByBranch(placements);

            // KPIs
            final kpis = _getTopOfficerKpis(filtered);
            final grouped = groupPlacements(filtered, groupBy);
            final labels = grouped.keys.toList();

            final barColor = colorScheme.primary;
            final barBgColor = withValues(colorScheme.surface, alpha: 0.19);

            final barGroups = List.generate(labels.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: grouped[labels[i]]!,
                    color: barColor,
                    width: 16,
                    borderRadius: BorderRadius.circular(6),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: grouped.values.reduce((a, b) => a > b ? a : b),
                      color: barBgColor,
                    ),
                  ),
                ],
              );
            });

            final chartWidth = (labels.length * 60).clamp(400, 2000).toDouble();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  // FILTRO DE SUCURSAL (con búsqueda tipo DropdownMenu)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sucursal:",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 260,
                          child: DropdownMenu<String>(
                            initialSelection: _branch ?? "Todas",
                            enableFilter: true,
                            requestFocusOnTap: true,
                            label: const Text('Filtrar por sucursal'),
                            dropdownMenuEntries: [
                              for (final b in branches)
                                DropdownMenuEntry(value: b, label: b),
                            ],
                            onSelected: (value) {
                              setState(() {
                                _branch = value == "Todas" ? null : value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // KPIs SECTION
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        _KpiTileCard(
                          label: 'Último Día',
                          value: kpis['Día'] as String,
                        ),
                        _KpiTileCard(
                          label: 'Última Semana',
                          value: kpis['Semana'] as String,
                        ),
                        _KpiTileCard(
                          label: 'Último Mes',
                          value: kpis['Mes'] as String,
                        ),
                        _KpiTileCard(
                          label: 'Último Año',
                          value: kpis['Año'] as String,
                        ),
                      ],
                    ),
                  ),
                  // Agrupar por
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Agrupar por:',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<PlacementGroupBy>(
                            value: groupBy,
                            borderRadius: BorderRadius.circular(12),
                            dropdownColor: colorScheme.surface,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<PlacementCubit>().changeGrouping(
                                  value,
                                );
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: PlacementGroupBy.day,
                                child: Text('Día'),
                              ),
                              DropdownMenuItem(
                                value: PlacementGroupBy.week,
                                child: Text('Semana'),
                              ),
                              DropdownMenuItem(
                                value: PlacementGroupBy.month,
                                child: Text('Mes'),
                              ),
                              DropdownMenuItem(
                                value: PlacementGroupBy.officer,
                                child: Text('Oficial'),
                              ),
                              DropdownMenuItem(
                                value: PlacementGroupBy.branch,
                                child: Text('Sucursal'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: SegmentedButton<_PlacementOrder>(
                          showSelectedIcon: false,
                          style: SegmentedButton.styleFrom(
                            backgroundColor: colorScheme.surface,
                            selectedBackgroundColor: withValues(
                              colorScheme.primary,
                              alpha: 0.13,
                            ),
                            foregroundColor: colorScheme.primary,
                            selectedForegroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            textStyle: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          segments: const [
                            ButtonSegment(
                              value: _PlacementOrder.fecha,
                              label: Text('Fecha'),
                            ),
                            ButtonSegment(
                              value: _PlacementOrder.montoDesc,
                              label: Text('Monto ↓'),
                            ),
                            ButtonSegment(
                              value: _PlacementOrder.montoAsc,
                              label: Text('Monto ↑'),
                            ),
                          ],
                          selected: <_PlacementOrder>{_order},
                          onSelectionChanged: (s) {
                            setState(() {
                              _order = s.first;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total colocado por ${_groupLabel(groupBy)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Gráfico centrado, tooltip theme-aware
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 2,
                        color: colorScheme.surface,
                        margin: EdgeInsets.zero,
                        child: SizedBox(
                          height: 320,
                          width: chartWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 24,
                              top: 72,
                              bottom: 12,
                            ),
                            child: BarChart(
                              BarChartData(
                                barGroups: barGroups,
                                gridData: FlGridData(
                                  show: true,
                                  drawHorizontalLine: true,
                                  horizontalInterval: _getInterval(
                                    grouped.values,
                                  ),
                                  getDrawingHorizontalLine: (value) => FlLine(
                                    color: withValues(
                                      colorScheme.onSurface,
                                      alpha: 0.08,
                                    ),
                                    strokeWidth: 1,
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 80,
                                      interval: _getInterval(grouped.values),
                                      getTitlesWidget: (value, _) => Text(
                                        _moneyFormat.format(value),
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, _) {
                                        final index = value.toInt();
                                        if (index >= 0 &&
                                            index < labels.length) {
                                          return Transform.rotate(
                                            angle: -0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: Text(
                                                labels[index],
                                                style: theme
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      fontSize: 11,
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipMargin: 24,
                                    tooltipPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 14,
                                    ),
                                    tooltipBorder: BorderSide(
                                      color: withValues(
                                        colorScheme.primary,
                                        alpha: 0.13,
                                      ),
                                      width: 0.9,
                                    ),
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) {
                                          return BarTooltipItem(
                                            _moneyFormat.format(rod.toY),
                                            TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              shadows: [
                                                Shadow(
                                                  color: withValues(
                                                    colorScheme.onSurface,
                                                    alpha: 0.21,
                                                  ),
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Detalle de colocaciones (${labels.length} ${_groupLabel(groupBy).toLowerCase()}s)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tabla centrada
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 1,
                        color: colorScheme.surface,
                        child: DataTable(
                          columnSpacing: 24,
                          headingRowColor: MaterialStateProperty.all(
                            colorScheme.surfaceVariant ??
                                withValues(colorScheme.surface, alpha: 0.97),
                          ),
                          columns: [
                            DataColumn(
                              label: Text(
                                _groupLabel(groupBy),
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            const DataColumn(label: Text('Monto Total')),
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
                                    _moneyFormat.format(
                                      grouped[labels[index]],
                                    ),
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
              ),
            );
          }
          return const Center(child: Text('Sin datos'));
        },
      ),
    );
  }

  static String _groupLabel(PlacementGroupBy groupBy) {
    switch (groupBy) {
      case PlacementGroupBy.day:
        return 'Día';
      case PlacementGroupBy.week:
        return 'Semana';
      case PlacementGroupBy.month:
        return 'Mes';
      case PlacementGroupBy.officer:
        return 'Oficial';
      case PlacementGroupBy.branch:
        return 'Sucursal';
    }
  }

  static double _getInterval(Iterable<double> values) {
    final max = values.isEmpty ? 1000 : values.reduce((a, b) => a > b ? a : b);
    final raw = max / 5;
    final interval = (raw / 500).ceil() * 500;
    return interval == 0 ? 500 : interval.toDouble();
  }
}

// Usar esta función para reemplazar withOpacity(x) => withValues(alpha:x)
Color withValues(Color c, {required double alpha}) {
  assert(alpha >= 0 && alpha <= 1.0);
  return c.withAlpha((alpha * 255).round());
}

// Widget KPI card, theme-aware
class _KpiTileCard extends StatelessWidget {
  final String label;
  final String value;
  const _KpiTileCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      elevation: 3,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? colorScheme.primary : colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
