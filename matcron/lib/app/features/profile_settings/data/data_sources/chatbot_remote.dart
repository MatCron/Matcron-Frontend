
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:matcron/app/features/profile_settings/data/models/chat_message.dart';
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
 final  StreamController<ChatMessageModel> _messageController = StreamController.broadcast();
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
      channel.stream.listen(
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
  if ( !_isConnected) {
    print("WebSocket is not connected. Retrying...");
    await connect(); // Ensure connection is established
  }
  final request = jsonEncode({"message": message});

  print("📤 Sending message: $message");

  try {
    channel.sink.add(request);
  } catch (e) {
    print("Error sending message: $e");
  }
}


  @override
  void dispose() {
    try {
      channel.sink.close();
      _isConnected = false;
      _messageController.close();
    } catch (e) {
      print("Error closing WebSocket: $e");
    }
  }
}
