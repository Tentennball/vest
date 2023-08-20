class ChatModel {
  final String name, content;
  final String createdAt;
  final String rx;
  final String tx;
  final bool isRead;

  ChatModel({
    required this.name,
    required this.content,
    required this.createdAt,
    required this.rx,
    required this.tx,
    required this.isRead,
  });
}
