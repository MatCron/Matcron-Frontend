// import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

// abstract class ChatbotRepository {
//   Future<ChatMessage> getChatbotResponse(String message);
// }


import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

abstract class ChatbotRepository {

  Stream<ChatMessage> getChatbotResponseStream();

  void sendMessage(String message);

  void dispose();
}
