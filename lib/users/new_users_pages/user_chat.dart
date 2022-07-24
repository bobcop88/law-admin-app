import 'package:adminapp/utils/chat_message_class.dart';
import 'package:adminapp/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserChat extends StatefulWidget {
  final String clientId;
  const UserChat({Key? key, required this.clientId}) : super(key: key);

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final _messageController = TextEditingController();
  String message = '';

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: StreamBuilder<List<ChatMessage>>(
            stream: DatabaseChat().readChatMessages(widget.clientId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Messages'),
                );
              } else if (snapshot.data!.length >= 0) {
                return ListView.separated(
                  reverse: true,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 5.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: message.sender == widget.clientId
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: message.sender == widget.clientId
                                        ? Colors.grey
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        message.messageText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: message.sender == widget.clientId
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat('ddMMMM HH:mm').format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        message.timeMessage)),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No Messages'),
                );
              }
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Type your message',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await DatabaseChat().startChat(widget.clientId,
        'QeyX9YxNuUOqBMABs3QsoiTNdqR2', _messageController.text.trim());

    _messageController.clear();
  }
}
