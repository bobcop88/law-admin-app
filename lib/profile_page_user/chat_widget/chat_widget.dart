import 'package:adminapp/users/new_users_pages/user_chat.dart';
import 'package:adminapp/utils/database.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final String user;
  final String token;
  final String firstName;
  final String lastName;
  bool chatVisible;
  final bool showNewChatMessage;
  ChatBox(
      {Key? key,
      required this.user,
      required this.chatVisible,
      required this.showNewChatMessage,
      required this.token,
      required this.firstName,
      required this.lastName})
      : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chat with ${widget.firstName} ${widget.lastName}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Divider(),
          widget.chatVisible
              ? Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: UserChat(
                                clientId: widget.user,
                                userDeviceToken: widget.token,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.showNewChatMessage
                              ? const Text(
                                  'New Message',
                                  style: TextStyle(color: Colors.red),
                                )
                              : const Text(''),
                          Badge(
                            showBadge: widget.showNewChatMessage,
                            badgeContent: const Text('1'),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  !widget.chatVisible
                                      ? widget.chatVisible = true
                                      : widget.chatVisible = false;
                                });

                                if (await DatabaseChat()
                                    .chatExists(widget.user)) {
                                  DatabaseChat().updateLastMessage(widget.user);
                                }

                                // print(await DatabaseChat()
                                //     .chatExists(widget.user));
                              },
                              child: const Text('Show Chat'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
