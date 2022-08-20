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
  List<Log> log = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Log>>(
        stream: DatabaseLogs().readAllLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            log = snapshot.data!;
            // createList() {
            //   log = [];
            //   for (var element in allLogs50) {
            //     log.add(element);
            //   }
            // }

            // createList();

            // serviceSorted();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Logs',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
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
                              label: Row(
                                children: [
                                  const Text(
                                    'Date',
                                  ),
                                ],
                              ),
                              // onSort: onSort,
                            ),
                            DataColumn(
                              label: Text('Type User'),
                            ),
                            DataColumn(
                              label: Text('Email address'),
                              // onSort: onSort,
                            ),
                            const DataColumn(
                              label: Text('Log Type'),
                            ),
                            const DataColumn(
                              label: Text('Action'),
                            ),
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

  // serviceSorted() {
  //   log.sort((a, b) => b.dateLog.compareTo(a.dateLog));
  // }

  // serviceSorted2() {
  //   print('called');
  //   // isAscending
  //   //     ? log.sort((a, b) => b.emailAddress.compareTo(a.emailAddress))
  //   //     : log.sort((a, b) => a.emailAddress.compareTo(b.emailAddress));

  //   return log.sort((a, b) => a.emailAddress.compareTo(b.emailAddress));

  //   // setState(() {
  //   //   isAscending ? isAscending = false : isAscending = true;
  //   // });
  // }

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     ascending
  //         ? log.sort((a, b) => b.dateLog.compareTo(a.dateLog))
  //         : log.sort((a, b) => a.dateLog.compareTo(b.dateLog));
  //   } else if (columnIndex == 1) {
  //     log.sort((a, b) => b.typeUser.compareTo(a.typeUser));
  //   } else if (columnIndex == 2) {
  //     ascending
  //         ? log.sort((a, b) => a.emailAddress.compareTo(b.emailAddress))
  //         : log.sort((a, b) => b.emailAddress.compareTo(a.emailAddress));
  //   }
  //   setState(() {
  //     sortColumnIndex = columnIndex;
  //     isAscending = ascending;
  //   });
  // }
}
