import 'package:biz_scope/features/chat/data/models/chat_message_model.dart';
import 'package:biz_scope/features/chat/domain/entities/chat_message.dart';
import 'package:biz_scope/features/chat/domain/repositories/chat_repository.dart';
import 'package:biz_scope/features/chat/domain/usecases/get_local_messages.dart';
import 'package:biz_scope/features/chat/domain/usecases/send_message.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  final GetLocalMessages getLocalMessagesUsecase;
  final SendMessage sendMessageUsecase;
  final ChatRepository repository;

  List<ChatMessage> _messages = [];
  bool _loading = false;
  String? _threadId;

  List<ChatMessage> get messages => _messages;
  bool get loading => _loading;
  String? get threadId => _threadId;

  ChatProvider({
    required this.getLocalMessagesUsecase,
    required this.sendMessageUsecase,
    required this.repository,
  });

  Future<void> init() async {
    _messages = await getLocalMessagesUsecase();
    notifyListeners();
  }

  Future<void> createThread() async {
    _threadId = await repository.createThread();
    notifyListeners();
  }

  Future<void> sendUserMessage(String text) async {
    if (text.trim().isEmpty || _loading || text.length > 500) return;
    _loading = true;
    notifyListeners();

    final userMsg = ChatMessageModel(
      id: UniqueKey().toString(),
      sender: "user",
      text: text.trim(),
    );

    final updatedMessages = [..._messages, userMsg];
    _messages = updatedMessages;
    await repository.saveLocalMessages(updatedMessages);

    ChatMessage? assistantMsg;
    if (_threadId == null) {
      await createThread();
    }
    if (_threadId != null) {
      assistantMsg = await sendMessageUsecase(
        text: text,
        threadId: _threadId!,
      );
    }

    if (assistantMsg != null) {
      final finalMessages = [..._messages, assistantMsg];
      _messages = finalMessages;
      await repository.saveLocalMessages(finalMessages);
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> resetChat() async {
    _messages = [];
    _threadId = null;
    await repository.clearLocalMessages();
    await createThread();
    notifyListeners();
  }
}
