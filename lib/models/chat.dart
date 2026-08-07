class ChatMessage {
  ChatMessage({required this.text, required this.time, required this.fromMe});
  final String text;
  final DateTime time;
  final bool fromMe;
}

class ChatThread {
  ChatThread({required this.doctorId, required this.messages, this.online = false});
  final String doctorId;
  final List<ChatMessage> messages;
  bool online;

  ChatMessage get last => messages.last;
  int get unread => messages.isNotEmpty && !messages.last.fromMe ? 1 : 0;
}
