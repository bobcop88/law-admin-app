class ChatMessage{

  final int timeMessage;
  final String sender;
  final String messageText;

  ChatMessage({
    required this.timeMessage,
    required this.sender,
    required this.messageText,
  });

  Map<String, dynamic> toJson() => {

    'timeMessage': timeMessage,
    'sender': sender,
    'messageText': messageText,

  };

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
    timeMessage: json['timeMessage'],
    sender: json['sender'],
    messageText: json['messageText'],

  );
}