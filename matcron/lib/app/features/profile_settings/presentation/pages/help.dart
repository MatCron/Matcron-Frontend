

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcron/app/features/profile_settings/domain/usecases/get_chatbot_response.dart';
import 'package:matcron/app/features/profile_settings/data/repository/chatbot_repository_impl.dart';
import 'package:matcron/app/features/profile_settings/data/data_sources/chatbot_remote.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isTyping = false;
  bool isListening = false;
  FlutterTts flutterTts = FlutterTts();
  SpeechToText speech = SpeechToText();
  String _userProfilePicture = "";

  final GetChatbotResponse _getChatbotResponse = GetChatbotResponse(
    repository: ChatbotRepositoryImpl(
      remoteDataSource: ChatbotRemoteDataSourceImpl(websocketUrl: "wss://ai.matcron.online/ws/chatbot"),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadUserProfilePicture();
    _initializeChatbot();
    _checkMicrophoneAvailability();
  }

  Future<void> _loadUserProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userProfilePicture = prefs.getString("profile_picture") ?? "assets/images/profile_image.png";
    });
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      messages.add({"user": text});
      isTyping = true;
    });
    _controller.clear();

    _getChatbotResponse.sendMessage(text);
  }

  Future<void> _initializeChatbot() async {
    await _getChatbotResponse.initialize();
    _getChatbotResponse.execute().listen((response) {
      setState(() {
        messages.add({"MatBot": response.text});
        isTyping = false;
      });
    });
  }

  void _checkMicrophoneAvailability() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        if (kDebugMode) {
          print('Microphone available: $available');
        }
      });
    } else {
      if (kDebugMode) {
        print("The user has denied the use of speech recognition.");
      }
    }
  }

  void _startListening() async {
    if (!isListening) {
      var available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          listenFor: const Duration(days: 1),
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
    }
  }

  @override
  void dispose() {
    _getChatbotResponse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text("MatBot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/robot-waving.gif',
                          height: size.width * 0.4,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          "Say hello to MatBot!",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUser = message.containsKey("user");

                      return Align(
                        alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.005,
                            horizontal: size.width * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(size.width * 0.03),
                                decoration: BoxDecoration(
                                  color: isUser ? theme.colorScheme.primary : theme.cardColor,
                                  borderRadius: BorderRadius.circular(size.width * 0.05),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isUser)
                                      CircleAvatar(
                                        backgroundImage: AssetImage(_userProfilePicture),
                                      ),
                                    SizedBox(width: size.width * 0.02),
                                    Flexible(
                                      child: Text(
                                        message.values.first,
                                        style: TextStyle(
                                          color: theme.colorScheme.onSurface,
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ),
                                    if (!isUser)
                                      const CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/robot.gif'),
                                      ),
                                  ],
                                ),
                              ),
                              if (!isUser)
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.volume_up),
                                    onPressed: () => flutterTts.speak(message.values.first),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: _startListening,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

