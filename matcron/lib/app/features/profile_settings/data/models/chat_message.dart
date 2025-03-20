
import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({
    required super.text,
    super.timestamp,
    super.status,
  });

  /// ✅ Updated factory constructor to match server JSON format
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['message'] ?? "", // ✅ Corrected key from 'text' → 'message'
      timestamp: json['timestamp'], // ✅ Matches server format
      status: json['status'], // ✅ Added status field
    );
  }

  /// ✅ Convert `ChatMessageModel` to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      "message": text, // ✅ Matches server response
      if (timestamp != null) "timestamp": timestamp,
      if (status != null) "status": status,
    };
  }
}
