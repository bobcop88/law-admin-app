import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesClass {
  List<DataRow> getRowsServices(List<ServiceDetails> service, context) {
    return service
        .map((ServiceDetails service) => DataRow(cells: [
              DataCell(
                Text(DateFormat('dd/MM/yy')
                    .format(DateTime.fromMicrosecondsSinceEpoch(
                        service.creationDate))
                    .toString()),
              ),
              DataCell(Text(service.serviceName)),
              DataCell(Text(service.emailUser)),
              DataCell(Text(service.currentState)),
              DataCell(ElevatedButton(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => UserProfileNew(id: user.id)));
                },
                child: const Text('View Service'),
              )),
            ]))
        .toList();
  }
}
