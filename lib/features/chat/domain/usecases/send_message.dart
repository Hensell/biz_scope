import 'package:biz_scope/features/chat/domain/entities/chat_message.dart';
import 'package:biz_scope/features/chat/domain/repositories/chat_repository.dart';

class SendMessage {
  SendMessage(this.repository);
  final ChatRepository repository;

  Future<ChatMessage?> call({
    required String text,
    required String threadId,
    int limit = 1,
  }) async {
    return repository.sendMessage(
      text: text,
      threadId: threadId,
      limit: limit,
    );
  }
}
