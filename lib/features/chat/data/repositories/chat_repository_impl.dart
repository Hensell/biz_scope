import 'package:biz_scope/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:biz_scope/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:biz_scope/features/chat/data/models/chat_message_model.dart';
import 'package:biz_scope/features/chat/domain/entities/chat_message.dart';
import 'package:biz_scope/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });
  final ChatLocalDatasource localDatasource;
  final ChatRemoteDatasource remoteDatasource;

  @override
  Future<List<ChatMessage>> getLocalMessages() async {
    return localDatasource.getMessages();
  }

  @override
  Future<void> saveLocalMessages(List<ChatMessage> messages) async {
    final models = messages
        .map(
          (e) => ChatMessageModel(
            id: e.id,
            sender: e.sender,
            text: e.text,
          ),
        )
        .toList();
    await localDatasource.saveMessages(models);
  }

  @override
  Future<void> clearLocalMessages() async {
    await localDatasource.clearMessages();
  }

  @override
  Future<String?> createThread() async {
    return remoteDatasource.createThread();
  }

  @override
  Future<ChatMessage?> sendMessage({
    required String text,
    required String threadId,
    int limit = 1,
  }) async {
    return remoteDatasource.sendMessage(
      text: text,
      threadId: threadId,
      limit: limit,
    );
  }
}
