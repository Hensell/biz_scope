import 'dart:convert';
import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:flutter/services.dart' show rootBundle;

class IncomeProjectionReportDataSource {
  static const String _jsonPath = 'assets/data_json/income_projection.json';

  Future<IncomeProjectionReport> loadReport() async {
    final data = await rootBundle.loadString(_jsonPath);
    final jsonMap = jsonDecode(data) as Map<String, dynamic>;
    return IncomeProjectionReport.fromJson(jsonMap);
  }
}
