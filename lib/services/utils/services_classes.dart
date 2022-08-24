import 'package:adminapp/profile_page_user/user_profile_page.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesClass {
  List<DataRow> getRowsServicesDashboard(
      List<ServiceDetails> service, context) {
    return service
        .map((ServiceDetails service) => DataRow(cells: [
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    DateFormat('dd/MM/yy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            service.creationDate))
                        .toString(),
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                          id: service.userId, showNewChatMessage: false)));
                },
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    service.serviceName,
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )),
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    service.emailUser,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              DataCell(Text(
                service.currentState,
                style: const TextStyle(fontSize: 12.0),
              )),
              // DataCell(ElevatedButton(
              //   style: const ButtonStyle(visualDensity: VisualDensity.compact),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => UserProfilePage(
              //               id: service.userId,
              //               showNewChatMessage: false,
              //             )));
              //   },
              //   child: const Text('View Service'),
              // )),
            ]))
        .toList();
  }

  List<DataRow> getRowsServices(List<ServiceDetails> service, context) {
    return service
        .map((ServiceDetails service) => DataRow(cells: [
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    DateFormat('dd/MM/yy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            service.creationDate))
                        .toString(),
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => UserProfilePage(id: user.id)));
                },
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    service.serviceName,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              )),
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    service.emailUser,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              DataCell(Text(
                service.currentState,
                style: const TextStyle(fontSize: 12.0),
              )),
              DataCell(ElevatedButton(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            id: service.userId,
                            showNewChatMessage: false,
                          )));
                },
                child: const Text('View Service'),
              )),
            ]))
        .toList();
  }
}
