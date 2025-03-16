// import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

// class ChatMessageModel extends ChatMessage {
//   ChatMessageModel({required String sender, required String text})
//       : super(sender: sender, text: text);

//   factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
//     return ChatMessageModel(
//       sender: json['sender'],
//       text: json['text'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"sender": sender, "text": text};
//   }
// }


import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  final String? timestamp; // 🔹 Optional timestamp
  final String? messageType; 

  ChatMessageModel({
    required String sender,
    required String text,
    this.timestamp,
    this.messageType,
  }) : super(sender: sender, text: text);


  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sender: json['sender'] ?? "unknown", 
      text: json['text'] ?? "",
      timestamp: json['timestamp'],
      messageType: json['type'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "text": text,
      if (timestamp != null) "timestamp": timestamp, 
      if (messageType != null) "type": messageType,
    };
  }
}
