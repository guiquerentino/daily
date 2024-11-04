class ChatMessageDto {
  final int? id;
  final int chatId;
  final String sender;
  final String content;
  final DateTime? sentAt;

  ChatMessageDto({
    this.id,
    required this.chatId,
    required this.sender,
    required this.content,
    this.sentAt,
  });

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      sender: json['sender'] as String,
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
    );
  }

  static List<ChatMessageDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ChatMessageDto.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'sender': sender,
      'content': content,
    };
  }
}
