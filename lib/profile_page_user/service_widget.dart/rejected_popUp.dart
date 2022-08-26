import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/notifications/notifications_database.dart';
import 'package:flutter/material.dart';

class RejectedWidget extends StatefulWidget {
  final String id;
  final String firstName;
  final String email;
  final String serviceName;
  final String token;
  const RejectedWidget(
      {Key? key,
      required this.id,
      required this.firstName,
      required this.email,
      required this.serviceName,
      required this.token})
      : super(key: key);

  @override
  State<RejectedWidget> createState() => _RejectedWidgetState();
}

class _RejectedWidgetState extends State<RejectedWidget> {
  bool isCheckedTrue = false;
  bool isCheckedFalse = true;
  final rejectedReasonController = TextEditingController();
  bool missingRejectedReason = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Please complete to request new documents or details',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Enter the reason of rejected',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          style: TextStyle(fontSize: 12.0),
                          controller: rejectedReasonController,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(),
                              hintText: 'Enter reason'),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: missingRejectedReason,
                  child: Row(
                    children: [
                      Text(
                        'Please enter a reason for rejection',
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'New document needed?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'If select Yes, the client will need to upload a new document. You can specify the document needed in the reason field. If select No, the client will be required to enter details as Text',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: CheckboxListTile(
                                    value: isCheckedTrue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedTrue = value!;
                                        isCheckedFalse = !value;
                                      });
                                    },
                                    title: Text('Yes'),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                                Flexible(
                                  child: CheckboxListTile(
                                    value: isCheckedFalse,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedFalse = value!;
                                        isCheckedTrue = !value;
                                      });
                                    },
                                    title: Text('No'),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (rejectedReasonController.text
                                        .trim()
                                        .isEmpty) {
                                      setState(() {
                                        missingRejectedReason == false
                                            ? missingRejectedReason = true
                                            : missingRejectedReason = false;
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      missingRejectedReason == false
                                          ? missingRejectedReason = true
                                          : missingRejectedReason = false;
                                      DatabaseServiceDetails(
                                              uid: widget.id,
                                              serviceName: widget.serviceName)
                                          .updateServiceRejected(
                                        widget.id,
                                        widget.serviceName,
                                        'currentState',
                                        'Documents Requested',
                                        rejectedReasonController.text.trim(),
                                        isCheckedTrue ? true : false,
                                      );

                                      Notifications().newNotificationUser(
                                          widget.id,
                                          widget.email,
                                          widget.serviceName);
                                      SendNotification(
                                              userDeviceToken: widget.token)
                                          .sendPushNotifications(
                                              title: 'Inscale Media App',
                                              body:
                                                  'New update on your service');
                                      EmailNotification()
                                          .sendEmailUpdateService(
                                              widget.firstName,
                                              widget.serviceName,
                                              widget.email);
                                    }
                                  },
                                  child: Text('Confirm Reject Service'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
