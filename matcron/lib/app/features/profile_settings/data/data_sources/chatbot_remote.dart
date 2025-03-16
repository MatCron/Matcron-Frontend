// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';


// abstract class ChatbotRemoteDataSource {
//   Future<ChatMessageModel> getChatbotResponse(String message);
// }

// class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
//   final http.Client client;

//   ChatbotRemoteDataSourceImpl({required this.client});

//   @override
//   Future<ChatMessageModel> getChatbotResponse(String message) async {
//     final response = await client.post(
//       Uri.parse("https://yourapi.com/chatbot"), // 🔹 Replace with your backend API
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({"message": message}),
//     );

//     if (response.statusCode == 200) {
//       return ChatMessageModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Failed to fetch chatbot response");
//     }
//   }
// }


// import 'dart:convert';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';

// abstract class ChatbotRemoteDataSource {
//   Stream<ChatMessageModel> getChatbotResponseStream();
//   void sendMessage(String message);
//   void dispose();
// }

// class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
//   final WebSocketChannel channel;

//   ChatbotRemoteDataSourceImpl({required String websocketUrl})
//       : channel = IOWebSocketChannel.connect(websocketUrl);

// @override
//   Stream<ChatMessageModel> getChatbotResponseStream() {
//     return channel.stream.map((event) {
//       try {
//         final data = jsonDecode(event);
//         return ChatMessageModel.fromJson(data);
//       } catch (e) {
//         return ChatMessageModel(sender: "MatBot", text: "Error processing response");
//       }
//     });
//   }


//   @override
//   void sendMessage(String message) {
//     final request = jsonEncode({"message": message});
//     channel.sink.add(request);
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
  
//   }
// }


import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';

abstract class ChatbotRemoteDataSource {
  Stream<ChatMessageModel> getChatbotResponseStream();
  void sendMessage(String message);
  void dispose();
}

class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
  final WebSocketChannel channel;

  ChatbotRemoteDataSourceImpl({required String websocketUrl})
      : channel = IOWebSocketChannel.connect(Uri.parse(websocketUrl));

  @override
  Stream<ChatMessageModel> getChatbotResponseStream() {
    return channel.stream.map((event) {
      try {
        final data = jsonDecode(event);
        return ChatMessageModel.fromJson(data);
      } catch (e) {
        return ChatMessageModel(sender: "MatBot", text: "Error processing response");
      }
    });
  }

  @override
  void sendMessage(String message) {
    try {
      final request = jsonEncode({"message": message});
      channel.sink.add(request);
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  void dispose() {
    try {
      channel.sink.close();
    } catch (e) {
      print("Error closing WebSocket: $e");
    }
  }
}
