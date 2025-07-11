import 'package:biz_scope/features/chat/presentation/providers/chat_provider.dart';
import 'package:biz_scope/features/chat/presentation/widgets/chat_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showChatModal(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ChangeNotifierProvider.value(
      value: Provider.of<ChatProvider>(context, listen: false),
      child: const ChatModal(),
    ),
  );
}
