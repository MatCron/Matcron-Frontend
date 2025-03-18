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


import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcron/core/resources/authorization.dart';

abstract class ChatbotRemoteDataSource {
  Future<void> connect();
  Stream<ChatMessageModel> getChatbotResponseStream();
  void sendMessage(String message);
  void dispose();
}

class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
   late WebSocketChannel channel;
  final String websocketUrl;
  StreamController<ChatMessageModel> _messageController = StreamController.broadcast();
  bool _isConnected = false;

    ChatbotRemoteDataSourceImpl({required this.websocketUrl}) {
    print("🟢 Using WebSocket URL: $websocketUrl"); // ✅ Debugging line
  }


  /// ✅ **Connect to WebSocket with Token Authentication**
  @override
  Future<void> connect() async {
    if (_isConnected) return;
 
    final String? token = await _getAuthToken();
    
    if (token == null || token.isEmpty) {
      print("⚠️ No token found, retrying in 3 seconds...");
      await Future.delayed(Duration(seconds: 3));
      await connect(); // Retry
      return;
    }

    try {
        final String correctedUrl = websocketUrl.replaceFirst("https://", "wss://");
        print("🔹 Corrected WebSocket URL: $correctedUrl");
        channel = IOWebSocketChannel.connect(Uri.parse(correctedUrl), headers: {
            "Authorization": "Bearer $token",
           });

      print("✅ WebSocket Connected!");

      _isConnected = true;

      /// ✅ **Listen for messages**
      channel!.stream.listen(
        (event) {
          final data = jsonDecode(event);
          _messageController.add(ChatMessageModel.fromJson(data));
        },
        onError: (error) {
          print("WebSocket error: $error");
          _isConnected = false;
              },
        onDone: () {
          print("WebSocket connection closed.");
       
        },
      );
    } catch (e) {
      print("Error connecting WebSocket: $e");
      _isConnected = false;
      _reconnect(); // 🔄 Try to reconnect
    }
  }

  /// ✅ **Retry Connection on Failure**
  Future<void> _reconnect() async {
    await Future.delayed(Duration(seconds: 3));
    print("🔄 Reconnecting WebSocket...");
    await connect();
  }

  Future<String?> _getAuthToken() async {
    final token = await AuthorizationService().getToken();
    print("🔹 Retrieved Token: $token"); // Debugging
    return token;
  }


  @override
  Stream<ChatMessageModel> getChatbotResponseStream() {
    return _messageController.stream;
  }

  // @override
  // Future<void> sendMessage(String message) async {
  //   if (channel == null || !_isConnected) {
  //     print("WebSocket is not connected. Retrying...");
  //     await connect(); // Ensure connection is established
  //   }

  //   final token = await _getAuthToken();
  //   final request = jsonEncode({"message": message, "token": token});

  //   try {
  //     channel!.sink.add(request);
  //   } catch (e) {
  //     print("Error sending message: $e");
  //   }
  // }


  @override
Future<void> sendMessage(String message) async {
  if (channel == null || !_isConnected) {
    print("WebSocket is not connected. Retrying...");
    await connect(); // Ensure connection is established
  }

  final token = await _getAuthToken();
  final request = jsonEncode({"message": message, "token": token});

  print("📤 Sending message: $message");

  try {
    channel!.sink.add(request);
  } catch (e) {
    print("Error sending message: $e");
  }
}


  @override
  void dispose() {
    try {
      channel?.sink.close();
      _isConnected = false;
      _messageController.close();
    } catch (e) {
      print("Error closing WebSocket: $e");
    }
  }
}
