import 'dart:convert';

import 'package:biz_scope/features/chat/data/models/chat_message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ChatRemoteDatasource {
  static const String _baseUrl = 'https://biz-scope-ai.henselldev.workers.dev';

  Future<String?> createThread() async {
    final url = Uri.parse('$_baseUrl/thread');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data['thread_id'] as String?;
    }
    return null;
  }

  Future<ChatMessageModel?> sendMessage({
    required String text,
    required String threadId,
    int limit = 1,
  }) async {
    final url = Uri.parse('$_baseUrl/chat');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': text,
        'thread_id': threadId,
        'limit': limit,
      }),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final botText = (data is List && data.isNotEmpty)
          ? data[0]['content'] as String? ?? 'No response.'
          : 'No response.';
      return ChatMessageModel(
        id: UniqueKey().toString(),
        sender: 'assistant',
        text: botText,
      );
    }
    return null;
  }
}
