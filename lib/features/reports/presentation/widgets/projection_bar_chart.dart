import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectionBarChart extends StatelessWidget {
  final List<ProjectionCategory> categories;

  const ProjectionBarChart({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final moneyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 0,
    );
    final labels = categories.map((e) => e.type).toList();

    final maxProjected = categories
        .map((c) => c.projectedPlacement)
        .fold<double>(0, (prev, elem) => elem > prev ? elem : prev);

    final double maxY =
        maxProjected * 1.38; // infla maxY, dale mucho aire arriba

    final barGroups = categories.asMap().entries.map((entry) {
      final index = entry.key;
      final cat = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: cat.projectedPlacement,
            width: 28,
            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.secondary.withOpacity(0.8),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY, // igual que el maxY del chart!
              color: colorScheme.surface.withOpacity(0.11),
            ),
          ),
        ],
      );
    }).toList();

    return SizedBox(
      height: 360, // ¡más alto!
      child: Padding(
        padding: const EdgeInsets.only(top: 60), // más padding arriba
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: (categories.length * 140).toDouble().clamp(320, 900),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                groupsSpace: 32,
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.14),
                    width: 1,
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: maxProjected / 5,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: colorScheme.secondary.withOpacity(0.13),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 80,
                      interval: maxProjected / 5,
                      getTitlesWidget: (value, meta) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          moneyFormat.format(value),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 54,
                      getTitlesWidget: (double value, _) {
                        final index = value.toInt();
                        return Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(
                            index >= 0 && index < labels.length
                                ? labels[index]
                                : '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                maxY: maxY,
                minY: 0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipMargin: 24,
                    tooltipPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    tooltipBorder: BorderSide(
                      color: colorScheme.primary.withOpacity(0.18),
                      width: 1.1,
                    ),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        moneyFormat.format(rod.toY),
                        const TextStyle(
                          color: Colors.white, // texto SIEMPRE blanco
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 4,
                              offset: Offset(0, 2),
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
    );
  }
}
