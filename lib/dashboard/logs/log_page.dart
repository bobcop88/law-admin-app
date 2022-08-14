import 'package:adminapp/utils/logs/database_logs.dart';
import 'package:adminapp/utils/logs/logs_class.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  int? sortColumnIndex;
  bool isAscending = false;
  late List<Log> log;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Log>>(
        stream: DatabaseLogs().readAllLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            log = snapshot.data!;

            serviceSorted() {
              log.sort((a, b) => b.dateLog.compareTo(a.dateLog));
            }

            serviceSorted();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DataTable(
                          sortAscending: isAscending,
                          sortColumnIndex: sortColumnIndex,
                          headingTextStyle: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                          columns: [
                            DataColumn(
                                label: Text(
                                  'Date',
                                ),
                                onSort: onSort),
                            DataColumn(
                                label: Text('Type User'), onSort: onSort),
                            DataColumn(
                                label: Text('Email address'), onSort: onSort),
                            DataColumn(label: Text('Log Type'), onSort: onSort),
                            DataColumn(label: Text('Action'), onSort: onSort),
                          ],
                          rows: DatabaseLogs().getRowsLogs(log, context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      log.sort((a, b) => b.typeUser.compareTo(a.typeUser));
    }
    if (columnIndex == 2) {
      ascending
          ? log.sort((a, b) => a.emailAddress.compareTo(b.emailAddress))
          : log.sort((a, b) => b.emailAddress.compareTo(a.emailAddress));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
