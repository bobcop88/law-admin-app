import 'package:adminapp/utils/chat_message_class.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/send_notifications_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserChat extends StatefulWidget {
  final String clientId;
  final String userDeviceToken;
  const UserChat(
      {Key? key, required this.clientId, required this.userDeviceToken})
      : super(key: key);

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
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        StreamBuilder<List<ChatMessage>>(
          stream: DatabaseChat().readChatMessages(widget.clientId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Messages'),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Expanded(
                child: Text(''),
              );
            } else {
              return Expanded(
                child: ListView.separated(
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
                ),
              );
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
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
    SendNotification(userDeviceToken: widget.userDeviceToken)
        .sendPushNotifications(
            title: 'Inscale Media App',
            body: 'You got a new chat message from admin');
  }

  // Future<bool> callOnFcmApiSendPushNotifications(
  //     {required String title, required String body}) async {
  //   const postUrl = 'https://fcm.googleapis.com/fcm/send';
  //   final data = {
  //     "to": widget.userDeviceToken,
  //     "notification": {
  //       "title": title,
  //       "body": body,
  //     },
  //     "data": {
  //       "type": '0rder',
  //       "id": '28',
  //       // "click_action": 'FLUTTER_NOTIFICATION_CLICK',
  //     }
  //   };

  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'key=AAAA5aVaC_A:APA91bHjAHukgqxDQ73rZWgx0b4u-KoTrj1h07HuV0_UfoKVnmanNr7W3jVTcnN5F482J_5J8hPVXgZsYws5e6Tm6i8phtAXimR-CC0fH3pEP-BeJHDxN-zSQNjOw7IYp6JGnopPaEUp' // 'key=YOUR_SERVER_KEY'
  //   };

  //   final response = await http.post(Uri.parse(postUrl),
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);

  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     // print('test ok push CFM');
  //     return true;
  //   } else {
  //     // print(' CFM error');
  //     // on failure do sth
  //     return false;
  //   }
  // }
}
