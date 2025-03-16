// import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
// import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';


// class GetChatbotResponse {
//   final ChatbotRepository repository;

//   GetChatbotResponse({required this.repository});

//   Future<ChatMessage> execute(String message) async {
//     return await repository.getChatbotResponse(message);
//   }
// }


import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';

class GetChatbotResponse {
  final ChatbotRepository repository;

  GetChatbotResponse({required this.repository});


  Stream<ChatMessage> execute() {
    return repository.getChatbotResponseStream();
  }

  void sendMessage(String message) {
    repository.sendMessage(message);
  }


  void dispose() {
    repository.dispose();
  }
}
