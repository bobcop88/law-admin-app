import 'package:adminapp/profile_page_user/user_profile_page.dart';
import 'package:adminapp/utils/notifications/notifications_class.dart';
import 'package:adminapp/utils/notifications/notifications_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndDrawerNotifications extends StatefulWidget {
  const EndDrawerNotifications({Key? key}) : super(key: key);

  @override
  State<EndDrawerNotifications> createState() => _EndDrawerNotificationsState();
}

class _EndDrawerNotificationsState extends State<EndDrawerNotifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Notifications',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 30.0,
          ),
          Flexible(
            child: StreamBuilder<List<NotificationsUserToAdmin>>(
                stream: NotificationsFromUsers().readNotificationsFromUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Row(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Row(
                      children: [Text('No Notifications')],
                    );
                  } else {
                    final notifications = snapshot.data!;

                    return ListView(
                      controller: ScrollController(),
                      children: notifications.map(buildNotification).toList(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget buildNotification(notifications) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Color.fromRGBO(19, 38, 63, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                notifications.isNew
                    ? Text(
                        'New',
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                notifications.isNew ? SizedBox(width: 5.0) : Container(),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 38, 63, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(notifications.notificationType,
                        style: TextStyle(color: Colors.white, fontSize: 11.0)),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  dateFormat(notifications.dateNotification),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: GestureDetector(
                    child: Text(
                      notifications.emailUser,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserProfilePage(
                                id: notifications.userId,
                                showNewChatMessage: false,
                              )));
                    },
                  ),
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Text(
                  notifications.nameUser,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(child: Text(notifications.notificationDetails))
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(visualDensity: VisualDensity.compact),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                              id: notifications.userId,
                              showNewChatMessage: false,
                            )));
                  },
                  child: Text(
                    'Go',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        NotificationsFromUsers().updateNotificationNew(
                            notifications.dateNotification.toString());
                      },
                      child: Text(
                        'Mark as read',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NotificationsFromUsers().deleteNotification(
                            notifications.dateNotification.toString());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 14.0,
                            // color: Color.fromRGBO(250, 169, 22, 1),
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String dateFormat(date) {
    final String time =
        DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(date));
    final dayMessage = DateTime.utc(
        (DateTime.fromMicrosecondsSinceEpoch(date)).toUtc().year,
        (DateTime.fromMicrosecondsSinceEpoch(date)).toUtc().month,
        (DateTime.fromMicrosecondsSinceEpoch(date)).toUtc().day);
    final today = DateTime.utc(DateTime.now().toUtc().year,
        DateTime.now().toUtc().month, DateTime.now().toUtc().day);

    if (dayMessage.difference(today).inDays == 0) {
      return 'Today' + ' ' + time;
    } else if (dayMessage.difference(today).inDays == -1) {
      return 'Yesterday' + ' ' + time;
    } else {
      return DateFormat('dd MMMM HH:mm')
          .format(DateTime.fromMicrosecondsSinceEpoch(date));
    }
  }
}
