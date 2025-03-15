class ChatMessage {
  final String sender; // "user" or "bot"
  final String text;

  ChatMessage({
    required this.sender, 
    required this.text}
    );



  ChatMessage copyWith({
    String? sender,
    String? text,

  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      text: text ?? this.text,

  
    );
  }
}

