
// help_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
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
  stt.SpeechToText speech = stt.SpeechToText();
  String _userProfilePicture = "";
  final GetChatbotResponse _getChatbotResponse = GetChatbotResponse(
    repository: ChatbotRepositoryImpl(
      remoteDataSource: ChatbotRemoteDataSourceImpl(client: http.Client()),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadUserProfilePicture();
  }

  Future<void> _loadUserProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userProfilePicture = prefs.getString("profile_picture") ?? "assets/images/profile_image.png";
    });
  }
  

    // Fetch profile picture from backend API
  // Future<void> _fetchUserProfilePicture() async {
  //   final response = await http.get(Uri.parse("https://yourapi.com/user/profile-picture"));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       _userProfilePicture = data['profile_picture_url'] ?? "";
  //     });
  //   } else {
  //     setState(() {
  //       _userProfilePicture = "";
  //     });
  //   }
  // }
  void _sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      messages.add({"user": text});
      isTyping = true;
    });
    _controller.clear();

    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      messages.add({"MatBot": "I am thinking..."});
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      messages.removeWhere((msg) => msg["MatBot"] == "I am thinking...");
      messages.add({"MatBot": "Hello! How can I assist you today?"});
      isTyping = false;
    });

    await flutterTts.speak("Hello! How can I assist you today?");
  }

  
void _startListening() async {
  bool available = await speech.initialize(
    onStatus: (status) {
      if (status == "done") {
        setState(() => isListening = false);
      }
    },
    onError: (error) {
      setState(() => isListening = false);
    },
  );

  if (available) {
    setState(() => isListening = true); 

    speech.listen(
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
        });
      },
      listenFor: Duration(seconds: 10),
      pauseFor: Duration(seconds: 3), 
      onSoundLevelChange: (level) {
        setState(() {}); 
      },
      cancelOnError: true, 
    );
  } else {
    setState(() => isListening = false);
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                         Text(
                          "Say hello to MatBot!",
                          style: TextStyle(color: theme.colorScheme.onSurface,  fontSize: 18, fontWeight: FontWeight.bold),
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
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? theme.colorScheme.primary : theme.cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
               child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isUser)
                       CircleAvatar(backgroundImage: AssetImage(_userProfilePicture),
                      ),

                      // backgroundImage: _userProfilePicture.isNotEmpty
                      //         ? NetworkImage(_userProfilePicture)
                      //         : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                      //   )
                            const SizedBox(width: 8),
                        Text(
                          message.values.first,
                          style:  TextStyle(color:theme.colorScheme.onSurface , fontSize: 12),
                        ),
                      
                      if (!isUser)
                          const SizedBox(width: 8),
                        if (!isUser)
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/robot.gif'),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
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
          if (isListening)
             Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.7),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/download.gif',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                   Text(
                    "Go ahead, I'm listening...",
                    style: TextStyle(fontSize: 18, color: theme.colorScheme.onSurface),
                  ),
                ],
              ),
            ),
             ),
        ],
      ),
    );
  }
}
