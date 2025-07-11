import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectionLineChart extends StatelessWidget {
  final ProjectionSummary summary;

  const ProjectionLineChart({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Solo para ejemplo: dos puntos (actual y proyectado)
    final spots = [
      FlSpot(0, summary.currentPortfolio),
      FlSpot(1, summary.projectedPortfolio),
    ];

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            horizontalInterval: summary.projectedPortfolio / 5,
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Current');
                    case 1:
                      return const Text('Projected');
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: summary.projectedPortfolio / 5,
                getTitlesWidget: (value, meta) =>
                    Text('\$${value.toStringAsFixed(0)}'),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: colorScheme.primary, width: 1),
          ),
          minX: 0,
          maxX: 1,
          minY: 0,
          maxY: summary.projectedPortfolio * 1.1,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: colorScheme.primary,
              barWidth: 5,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.3),
                    colorScheme.secondary.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: spots,
            ),
          ],
        ),
      ),
    );
  }
}
