import 'package:adminapp/utils/logs/database_logs.dart';
import 'package:adminapp/utils/logs/logs_class.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Log>>(
        stream: DatabaseLogs().readAllLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            final log = snapshot.data!;
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
                          headingTextStyle: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                          columns: [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Type User')),
                            DataColumn(label: Text('Email address')),
                            DataColumn(label: Text('Log Type')),
                            DataColumn(label: Text('Action')),
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
}
