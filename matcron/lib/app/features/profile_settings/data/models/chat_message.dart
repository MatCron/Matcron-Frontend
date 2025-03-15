import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({required String sender, required String text})
      : super(sender: sender, text: text);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sender: json['sender'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"sender": sender, "text": text};
  }
}
