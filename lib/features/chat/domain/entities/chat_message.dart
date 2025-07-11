class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
  });
  final String id;
  final String sender;
  final String text;
}
