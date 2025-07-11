import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectionBarChart extends StatelessWidget {
  final List<ProjectionCategory> categories;

  const ProjectionBarChart({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labels = categories.map((e) => e.type).toList();

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
          ),
        ],
      );
    }).toList();

    final double maxY =
        categories
            .map((c) => c.projectedPlacement)
            .fold<double>(0, (prev, elem) => elem > prev ? elem : prev) *
        1.2;

    return SizedBox(
      height: 300, // más alto para que entren las letras
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
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
                  horizontalInterval: maxY / 5,
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
                      interval: maxY / 5,
                      getTitlesWidget: (value, meta) => Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width < 700 ? 25 : 0,
                        ),
                        child: Text(
                          '\$${value.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 54, // MÁS ESPACIO ABAJO
                      getTitlesWidget: (double value, _) {
                        final index = value.toInt();
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 22.0,
                            bottom: 2.0,
                          ), // MÁS ESPACIO ARRIBA Y ABAJO
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
                        // Si quieres girar la etiqueta:
                        // return Transform.rotate(
                        //   angle: -0.35, // Rota unos -20 grados aprox
                        //   child: Text(...),
                        // );
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
                maxY: maxY,
                minY: 0,
                barTouchData: BarTouchData(enabled: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
