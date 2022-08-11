import 'package:adminapp/dashboard/utils/admin_profile_class.dart';

class ChatMessage {
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

class LastChatMessage {
  final String admin;
  final bool isRead;
  final int timeLastMessage;
  final String senderLastMessage;
  final String textLastMessage;
  final String user;

  LastChatMessage(
      {required this.admin,
      required this.isRead,
      required this.timeLastMessage,
      required this.senderLastMessage,
      required this.textLastMessage,
      required this.user});

  static LastChatMessage fromJson(Map<String, dynamic> json) => LastChatMessage(
      admin: json['admin'],
      isRead: json['isRead'],
      timeLastMessage: json['timeLastMessage'],
      senderLastMessage: json['senderLastMessage'],
      textLastMessage: json['textLastMessage'],
      user: json['user']);
}
