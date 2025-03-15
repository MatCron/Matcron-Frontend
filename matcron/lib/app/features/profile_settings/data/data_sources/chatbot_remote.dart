import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';


abstract class ChatbotRemoteDataSource {
  Future<ChatMessageModel> getChatbotResponse(String message);
}

class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
  final http.Client client;

  ChatbotRemoteDataSourceImpl({required this.client});

  @override
  Future<ChatMessageModel> getChatbotResponse(String message) async {
    final response = await client.post(
      Uri.parse("https://yourapi.com/chatbot"), // 🔹 Replace with your backend API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      return ChatMessageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch chatbot response");
    }
  }
}
