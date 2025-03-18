


import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';
import 'package:matcron/app/features/profile_settings/data/repository/chatbot_repository_impl.dart';

class GetChatbotResponse {
  final ChatbotRepository repository;

  GetChatbotResponse({required this.repository});

  Future<void> initialize() async {
    await (repository as ChatbotRepositoryImpl).initialize();
  }

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
