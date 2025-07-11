import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/features/reports/presentation/utils/placement_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlacementChart extends StatelessWidget {
  const PlacementChart({
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

    final moneyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    );

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
              toY: grouped.values.isEmpty
                  ? 0
                  : grouped.values.reduce((a, b) => a > b ? a : b),
              color: barBgColor,
            ),
          ),
        ],
      );
    });

    final chartWidth = (labels.length * 60).clamp(400, 2000).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
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
                      horizontalInterval: getInterval(grouped.values),
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: withValues(colorScheme.onSurface, alpha: 0.08),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 80,
                          interval: getInterval(grouped.values),
                          getTitlesWidget: (value, _) => Text(
                            moneyFormat.format(value),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final index = value.toInt();
                            if (index >= 0 && index < labels.length) {
                              return Transform.rotate(
                                angle: -0.6,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    labels[index],
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontSize: 11,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
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
                          color: withValues(colorScheme.primary, alpha: 0.13),
                          width: 0.9,
                        ),
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            moneyFormat.format(rod.toY),
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
    );
  }
}
