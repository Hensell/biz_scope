import 'package:biz_scope/features/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getLocalMessages();
  Future<void> saveLocalMessages(List<ChatMessage> messages);
  Future<void> clearLocalMessages();

  Future<String?> createThread();
  Future<ChatMessage?> sendMessage({
    required String text,
    required String threadId,
    int limit,
  });
}
