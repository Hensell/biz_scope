import 'package:biz_scope/features/chat/presentation/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatModal extends StatefulWidget {
  const ChatModal({super.key});

  @override
  State<ChatModal> createState() => _ChatModalState();
}

class _ChatModalState extends State<ChatModal> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ChatProvider>(context, listen: false)..init();
    if (provider.threadId == null) {
      provider.createThread();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, _) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "FDL AI Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          chat.resetChat();
                        },
                        child: const Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                // Mensajes
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: chat.messages.length,
                    itemBuilder: (context, i) {
                      final msg = chat.messages[i];
                      final isUser = msg.sender == "user";
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.black : Colors.grey[200],
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (chat.loading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Assistant is typing...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                // Input
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          enabled: !chat.loading,
                          maxLength: 500,
                          onSubmitted: (value) => _send(chat),
                          decoration: const InputDecoration(
                            hintText: "Type your message...",
                            counterText: "",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed:
                            chat.loading || _controller.text.trim().isEmpty
                            ? null
                            : () => _send(chat),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _send(ChatProvider chat) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    chat.sendUserMessage(text);
    _controller.clear();
  }
}
