import 'package:adminapp/services/utils/services_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final _userController = TextEditingController();
  String _searchService = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ServiceDetails>>(
        stream: DatabaseServiceList().readAllServicesNew(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ServiceDetails> service;

            if (_searchService.isNotEmpty) {
              service = snapshot.data!.where((element) {
                return element.serviceName
                        .toLowerCase()
                        .contains(_searchService.toLowerCase()) ||
                    element.emailUser
                        .toLowerCase()
                        .contains(_searchService.toLowerCase());
              }).toList();
            } else {
              service = snapshot.data!;
            }
            serviceSorted() {
              service.sort((a, b) => b.creationDate.compareTo(a.creationDate));
            }

            serviceSorted();

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 300.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: TextField(
                                controller: _userController,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                                  prefixIcon: Icon(Icons.search_outlined),
                                  hintText: 'Search Service',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchService = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DataTable(
                          headingTextStyle: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                          columns: [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Service')),
                            DataColumn(label: Text('User')),
                            DataColumn(label: Text('Status')),
                            // DataColumn(label: Text('')),
                          ],
                          rows:
                              ServicesClass().getRowsServices(service, context),
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
