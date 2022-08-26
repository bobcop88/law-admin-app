import 'package:adminapp/profile_page_user/service_widget.dart/rejected_popUp.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/notifications/notifications_database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServiceSelectedDetails extends StatefulWidget {
  final String id;
  final String firstName;
  final String email;
  final String serviceName;
  final String token;

  const ServiceSelectedDetails(
      {Key? key,
      required this.id,
      required this.serviceName,
      required this.token,
      required this.firstName,
      required this.email})
      : super(key: key);

  @override
  State<ServiceSelectedDetails> createState() => _ServiceSelectedDetailsState();
}

class _ServiceSelectedDetailsState extends State<ServiceSelectedDetails> {
  bool updateCurrentState = false;
  bool updateDoc1Status = false;
  bool updateDoc2Status = false;
  String currentState = 'Pending';
  String doc1Status = 'Verified';
  String doc2Status = 'Verified';
  bool isCheckedTrue = false;
  bool isCheckedFalse = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ServiceDetails>(
      stream: DatabaseServiceDetails(
              uid: widget.id, serviceName: widget.serviceName)
          .readUserServices(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text(''));
        } else {
          final service = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Service',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      service.serviceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Details',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  onPressed: showRejectPopUp,
                                  child: Text('Reject'),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Start Date: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMMM yyyy HH:mm').format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          service.creationDate)),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Current State: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  updateCurrentState
                                      ? Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: SizedBox(
                                                height: 20.0,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  isDense: false,
                                                  value: currentState,
                                                  style: const TextStyle(
                                                      fontSize: 14.0),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      currentState = newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Completed',
                                                    'Pending',
                                                    'Started'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Text(service.currentState)),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      updateCurrentState ? 'Save' : 'Update',
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        updateCurrentState
                                            ? updateCurrentState = false
                                            : updateCurrentState = true;
                                      });
                                      if (updateCurrentState == false) {
                                        DatabaseServiceDetails(
                                                uid: widget.id,
                                                serviceName: widget.serviceName)
                                            .updateServiceDetails(
                                                widget.id,
                                                widget.serviceName,
                                                'currentState',
                                                currentState);

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
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      updateCurrentState ? 'Cancel' : '',
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        updateCurrentState
                                            ? updateCurrentState = false
                                            : updateCurrentState = true;
                                      });
                                      currentState = service.currentState;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Document 1 Status : ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                updateDoc1Status
                                    ? Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: SizedBox(
                                              height: 20.0,
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                isDense: false,
                                                value: doc1Status,
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    doc1Status = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  'Verified',
                                                  'Pending',
                                                  'Not Verified',
                                                  'Rejected'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(child: Text(service.doc1Status)),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                InkWell(
                                  child: Text(
                                    updateDoc1Status ? 'Save' : 'Update',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      updateDoc1Status
                                          ? updateDoc1Status = false
                                          : updateDoc1Status = true;
                                      if (updateDoc1Status == false) {
                                        DatabaseServiceDetails(
                                                uid: widget.id,
                                                serviceName: widget.serviceName)
                                            .updateServiceDetails(
                                                widget.id,
                                                widget.serviceName,
                                                'doc1Status',
                                                doc1Status);
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                InkWell(
                                  child: Text(
                                    updateDoc1Status ? 'Cancel' : '',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      updateDoc1Status
                                          ? updateDoc1Status = false
                                          : updateDoc1Status = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Document 2 Status: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  updateDoc2Status
                                      ? Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: SizedBox(
                                                height: 20.0,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  isDense: false,
                                                  value: doc2Status,
                                                  style: const TextStyle(
                                                      fontSize: 14.0),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      doc2Status = newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Verified',
                                                    'Pending',
                                                    'Not Verified',
                                                    'Rejected'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Text(service.doc2Status)),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      updateDoc2Status ? 'Save' : 'Update',
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        updateDoc2Status
                                            ? updateDoc2Status = false
                                            : updateDoc2Status = true;
                                        if (updateDoc2Status == false) {
                                          DatabaseServiceDetails(
                                                  uid: widget.id,
                                                  serviceName:
                                                      widget.serviceName)
                                              .updateServiceDetails(
                                                  widget.id,
                                                  widget.serviceName,
                                                  'doc2Status',
                                                  doc2Status);
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      updateDoc2Status ? 'Cancel' : '',
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        updateDoc2Status
                                            ? updateDoc2Status = false
                                            : updateDoc2Status = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    service.doc1Url != 'not-applicable'
                        ? Expanded(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Document 1',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                              size: 30.0,
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                launchUrl(
                                                    Uri.parse(service.doc1Url),
                                                    webOnlyWindowName:
                                                        '_blank');
                                              },
                                              child:
                                                  const Text('View Document'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Document 2',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                              size: 30.0,
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                launchUrl(
                                                    Uri.parse(service.doc2Url),
                                                    webOnlyWindowName:
                                                        '_blank');
                                              },
                                              child:
                                                  const Text('View Document'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  showRejectPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RejectedWidget(
            id: widget.id,
            firstName: widget.firstName,
            email: widget.email,
            serviceName: widget.serviceName,
            token: widget.token,
          );
        });
  }
}
