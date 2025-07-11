import 'dart:convert';

import 'package:biz_scope/features/chat/data/models/chat_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatLocalDatasource {
  static const _key = 'chat_messages';

  Future<List<ChatMessageModel>> getMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveMessages(List<ChatMessageModel> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(messages.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> clearMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
