import 'package:biz_scope/features/chat/domain/entities/chat_message.dart';
import 'package:biz_scope/features/chat/domain/repositories/chat_repository.dart';

class GetLocalMessages {
  GetLocalMessages(this.repository);
  final ChatRepository repository;

  Future<List<ChatMessage>> call() async {
    return repository.getLocalMessages();
  }
}
