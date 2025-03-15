
import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';
import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
import 'package:matcron/app/features/profile_settings/data/data_sources/chatbot_remote.dart';


class ChatbotRepositoryImpl implements ChatbotRepository {
  final ChatbotRemoteDataSource remoteDataSource;

  ChatbotRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ChatMessage> getChatbotResponse(String message) async {
    return await remoteDataSource.getChatbotResponse(message);
  }
}
