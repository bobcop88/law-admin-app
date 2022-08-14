import 'package:adminapp/profile_page_user/user_profile_page.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesClass {
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
                    style: TextStyle(fontSize: 12.0),
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
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              )),
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    service.emailUser,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              DataCell(Text(
                service.currentState,
                style: TextStyle(fontSize: 12.0),
              )),
              // DataCell(ElevatedButton(
              //   style: ButtonStyle(visualDensity: VisualDensity.compact),
              //   onPressed: () {
              //     // Navigator.of(context).push(MaterialPageRoute(
              //     //     builder: (context) => UserProfileNew(id: user.id)));
              //   },
              //   child: const Text(
              //     'View Service',
              //     style: TextStyle(fontSize: 12.0),
              //   ),
              // )),
            ]))
        .toList();
  }
}
