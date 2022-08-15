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
  bool isAscending = true;
  // List<Log> log = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Log>>(
        stream: DatabaseLogs().readAllLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            List<Log> log = snapshot.data!;

            serviceSorted() {
              log.sort((a, b) => b.dateLog.compareTo(a.dateLog));
            }

            serviceSorted();

            // serviceSorted2() {
            //   print('called');
            //   isAscending
            //       ? log.sort((a, b) => b.typeUser.compareTo(a.typeUser))
            //       : log.sort((a, b) => a.typeUser.compareTo(b.typeUser));

            //   setState(() {
            //     isAscending ? isAscending = false : isAscending = true;
            //   });
            // }

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
                          // sortAscending: isAscending,
                          // sortColumnIndex: sortColumnIndex,
                          headingTextStyle: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                          columns: [
                            DataColumn(
                              label: Row(
                                children: [
                                  const Text(
                                    'Date',
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // print('clicked');
                                        // print(isAscending);
                                        // serviceSorted2();
                                      },
                                      child: const Icon(Icons.sort))
                                ],
                              ),
                            ),
                            const DataColumn(
                              label: Text('Type User'),
                            ),
                            const DataColumn(
                              label: Text('Email address'),
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

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 1) {
  //     log.sort((a, b) => b.typeUser.compareTo(a.typeUser));
  //   }
  //   if (columnIndex == 2) {
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
