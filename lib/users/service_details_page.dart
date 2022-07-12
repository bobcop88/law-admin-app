import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceSelectedDetails extends StatefulWidget {
  final String id;
  final String serviceName;

  const ServiceSelectedDetails(
      {Key? key, required this.id, required this.serviceName})
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
          return Center(child: Text(''));
        } else {
          final service = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Service Details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service.serviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
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
                Divider(),
                Row(
                  children: [
                    Text(
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
                                child: Container(
                                  height: 20.0,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: false,
                                    value: currentState,
                                    style: TextStyle(fontSize: 14.0),
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
                                          style: TextStyle(
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
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateCurrentState ? 'Save' : 'Update',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          updateCurrentState
                              ? updateCurrentState = false
                              : updateCurrentState = true;
                          if (updateCurrentState == false) {
                            DatabaseServiceDetails(
                                    uid: widget.id,
                                    serviceName: widget.serviceName)
                                .updateServiceDetails(
                                    widget.id,
                                    widget.serviceName,
                                    'currentState',
                                    currentState);
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateCurrentState ? 'Cancel' : '',
                        style: TextStyle(
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
                Divider(),
                Row(
                  children: [
                    Text(
                      'Doc 1 Status: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    updateDoc1Status
                        ? Expanded(
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Container(
                                  height: 20.0,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: false,
                                    value: doc1Status,
                                    style: TextStyle(fontSize: 14.0),
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
                                          style: TextStyle(
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
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateDoc1Status ? 'Save' : 'Update',
                        style: TextStyle(
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
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateDoc1Status ? 'Cancel' : '',
                        style: TextStyle(
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
                Divider(),
                Row(
                  children: [
                    Text(
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
                                child: Container(
                                  height: 20.0,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: false,
                                    value: doc2Status,
                                    style: TextStyle(fontSize: 14.0),
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
                                          style: TextStyle(
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
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateDoc2Status ? 'Save' : 'Update',
                        style: TextStyle(
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
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      child: Text(
                        updateDoc2Status ? 'Cancel' : '',
                        style: TextStyle(
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
          );
        }
      },
    );
  }
}
