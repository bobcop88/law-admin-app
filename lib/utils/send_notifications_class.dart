import 'dart:convert';
import 'package:http/http.dart' as http;

class SendNotification {
  String? userDeviceToken;

  SendNotification({required this.userDeviceToken});

  Future<bool> sendPushNotifications(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": userDeviceToken,
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        // "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAA5aVaC_A:APA91bHjAHukgqxDQ73rZWgx0b4u-KoTrj1h07HuV0_UfoKVnmanNr7W3jVTcnN5F482J_5J8hPVXgZsYws5e6Tm6i8phtAXimR-CC0fH3pEP-BeJHDxN-zSQNjOw7IYp6JGnopPaEUp' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      // print('test ok push CFM');
      return true;
    } else {
      // print(' CFM error');
      // on failure do sth
      return false;
    }
  }
}
