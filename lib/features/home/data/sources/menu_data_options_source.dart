import 'dart:convert';

import 'package:biz_scope/features/home/data/models/menu_option.dart';
import 'package:flutter/services.dart' show rootBundle;

class MenuOptionsDataSource {
  static const String _jsonPath = 'assets/menu_options.json';

  Future<List<MenuOption>> loadMenuOptions() async {
    final data = await rootBundle.loadString(_jsonPath);
    final jsonList = jsonDecode(data) as List<dynamic>;
    return jsonList
        .map((e) => MenuOption.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
