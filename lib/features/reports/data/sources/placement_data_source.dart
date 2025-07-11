import 'dart:convert';

import 'package:biz_scope/features/reports/data/models/placement.dart';
import 'package:flutter/services.dart' show rootBundle;

class PlacementDataSource {
  static const String _jsonPath = 'assets/data_json/placements.json';

  Future<List<Placement>> loadPlacements() async {
    final data = await rootBundle.loadString(_jsonPath);
    final jsonList = jsonDecode(data) as List<dynamic>;
    return jsonList
        .map((e) => Placement.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
