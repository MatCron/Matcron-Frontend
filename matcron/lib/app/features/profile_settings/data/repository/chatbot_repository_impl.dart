
// import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';
// import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
// import 'package:matcron/app/features/profile_settings/data/data_sources/chatbot_remote.dart';


// class ChatbotRepositoryImpl implements ChatbotRepository {
//   final ChatbotRemoteDataSource remoteDataSource;

//   ChatbotRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<ChatMessage> getChatbotResponse(String message) async {
//     return await remoteDataSource.getChatbotResponse(message);
//   }
// }


import 'package:matcron/app/features/profile_settings/domain/entities/chat_message.dart';
import 'package:matcron/app/features/profile_settings/domain/repositories/chatbot_repository.dart';
import 'package:matcron/app/features/profile_settings/data/data_sources/chatbot_remote.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
    final ChatbotRemoteDataSource remoteDataSource;
  bool _isInitialized = false;

  ChatbotRepositoryImpl({required this.remoteDataSource});

  Future<void> initialize() async {
    if (!_isInitialized) {
      await remoteDataSource.connect();
      _isInitialized = true;
    }
  }


  @override
  Stream<ChatMessage> getChatbotResponseStream() {
    return remoteDataSource.getChatbotResponseStream();
  }

  @override
  void sendMessage(String message) async {
    await initialize(); 
    remoteDataSource.sendMessage(message);
  }

  @override
  void dispose() {
    remoteDataSource.dispose();
  }
}
