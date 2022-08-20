import 'package:adminapp/utils/logs/logs_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatabaseLogs {
  Stream<List<Log>> readAllLogs() {
    return FirebaseFirestore.instance
        .collection('logs')
        .orderBy('dateLog', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Log.fromJson(doc.data())).toList());
  }

  Future<List<Log>> getAllLogs() async {
    final List<Log> list = await FirebaseFirestore.instance
        .collection('logs')
        .get()
        .then(
            (value) => value.docs.map((e) => Log.fromJson(e.data())).toList());

    return list;
  }

  List<DataRow> getRowsLogs(List<Log> log, context) {
    return log
        .map((Log log) => DataRow(cells: [
              DataCell(
                Text(
                  DateFormat('dd/MM/yy HH:ss')
                      .format(DateTime.fromMicrosecondsSinceEpoch(log.dateLog))
                      .toString(),
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ),
              DataCell(
                  Text(log.typeUser, style: const TextStyle(fontSize: 12.0))),
              DataCell(Text(log.emailAddress,
                  style: const TextStyle(fontSize: 12.0))),
              DataCell(
                  Text(log.logType, style: const TextStyle(fontSize: 12.0))),
              DataCell(
                  Text(log.action, style: const TextStyle(fontSize: 12.0))),
            ]))
        .toList();
  }
}
