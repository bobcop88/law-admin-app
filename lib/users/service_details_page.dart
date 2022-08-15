import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/send_notifications_class.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
                          Row(
                            children: const [
                              Text(
                                'Details',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Start Date: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy').format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        service.creationDate)),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
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
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  currentState = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Completed',
                                                'Pending',
                                                'Documents Requested',
                                                'Started'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
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
                                  : Expanded(child: Text(service.currentState)),
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
                                        'don.calogero88@gmail.com',
                                        widget.serviceName);
                                    SendNotification(
                                            userDeviceToken: widget.token)
                                        .sendPushNotifications(
                                            title: 'Inscale Media App',
                                            body: 'New update on your service');
                                    EmailNotification().sendEmailUpdateService(
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
                                },
                              ),
                            ],
                          ),
                          const Divider(),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Doc 1: ',
                          //       style: TextStyle(
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //     TextButton(
                          //       onPressed: () {
                          //         _showDocPreview(service.doc1Url);
                          //       },
                          //       child: Text('Show'),
                          //     ),
                          //   ],
                          // ),
                          // Divider(),
                          Row(
                            children: [
                              const Text(
                                'Doc 1 : ',
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
                                                return DropdownMenuItem<String>(
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
                          const Divider(),
                          Row(
                            children: [
                              const Text(
                                'Doc 2 Status: ',
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
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  doc2Status = newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Verified',
                                                'Pending',
                                                'Not Verified',
                                                'Rejected'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
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
                                  : Expanded(child: Text(service.doc2Status)),
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
                                              serviceName: widget.serviceName)
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showDocPreview(service.doc1Url);
                              },
                              child: Image.network(
                                service.doc1Url,
                                height: 200,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDocPreview(service.doc2Url);
                              },
                              child: Image.network(
                                service.doc2Url,
                                height: 200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future _showDocPreview(docUrl) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(docUrl));
                    },
                    child: const Text('Download'),
                  ),
                ],
              ),
              Image.network(
                docUrl,
              ),
            ],
          );
        });
  }
}
