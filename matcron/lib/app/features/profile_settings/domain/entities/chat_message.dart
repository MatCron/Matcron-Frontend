// class ChatMessage {
//   final String sender;
//   final String text;

//   ChatMessage({
//     required this.sender, 
//     required this.text}
//     );



//   ChatMessage copyWith({
//     String? sender,
//     String? text,

//   }) {
//     return ChatMessage(
//       sender: sender ?? this.sender,
//       text: text ?? this.text,

  
//     );
//   }
// }


// class ChatMessage {
//   final String sender;
//   final String text;
//   final String? timestamp; 
//   final String? messageType; 

//   ChatMessage({
//     required this.sender,
//     required this.text,
//     this.timestamp,
//     this.messageType,
//   });

//   ChatMessage copyWith({
//     String? sender,
//     String? text,
//     String? timestamp,
//     String? messageType,
//   }) {
//     return ChatMessage(
//       sender: sender ?? this.sender,
//       text: text ?? this.text,
//       timestamp: timestamp ?? this.timestamp,
//       messageType: messageType ?? this.messageType,
//     );
//   }

//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       sender: json['sender'] ?? "Unknown",
//       text: json['text'] ?? "",
//       timestamp: json['timestamp'], 
//       messageType: json['type'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "sender": sender,
//       "text": text,
//       if (timestamp != null) "timestamp": timestamp, 
//       if (messageType != null) "type": messageType, 
//     };
//   }
// }


class ChatMessage {
  final String text; // ✅ Corrected field for message
  final String? timestamp;
  final String? status; // ✅ Added status field (optional)

  ChatMessage({
    required this.text,
    this.timestamp,
    this.status,
  });

  /// ✅ Factory constructor to create an instance from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['message'] ?? "", // ✅ Corrected from 'text' to 'message'
      timestamp: json['timestamp'], // ✅ Matches the JSON format
      status: json['status'], // ✅ Added status parsing
    );
  }

  /// ✅ Convert `ChatMessage` to JSON
  Map<String, dynamic> toJson() {
    return {
      "message": text, // ✅ Match JSON format
      if (timestamp != null) "timestamp": timestamp,
      if (status != null) "status": status,
    };
  }
}
