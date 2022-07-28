import 'package:adminapp/utils/logs/logs_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatabaseLogs {
  Stream<List<Log>> readAllLogs() {
    return FirebaseFirestore.instance.collection('logs').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Log.fromJson(doc.data())).toList());
  }

  List<DataRow> getRowsLogs(List<Log> log, context) {
    return log
        .map((Log log) => DataRow(cells: [
              DataCell(
                Text(DateFormat('dd/MM/yy')
                    .format(DateTime.fromMicrosecondsSinceEpoch(log.dateLog))
                    .toString()),
              ),
              DataCell(Text(log.typeUser)),
              DataCell(Text(log.emailAddress)),
              DataCell(Text(log.logType)),
              DataCell(Text(log.action)),
            ]))
        .toList();
  }
}
