import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

abstract class ChatbotRepository {
  Future<ChatMessage> getChatbotResponse(String message);
}
