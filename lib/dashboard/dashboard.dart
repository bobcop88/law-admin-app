import 'package:adminapp/dashboard/widgets/buildChatsDashboard.dart';
import 'package:adminapp/services/utils/services_classes.dart';
import 'package:adminapp/profile_page_user/user_profile_page.dart';
import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/chat_message_class.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final adminUser = FirebaseAuth.instance.currentUser!;
  // final verifiedUsers = [];
  List nationalityUsers = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserCompleteProfile>>(
        stream: DatabaseUsers().readAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final users = snapshot.data!;
            users.forEach((element) {
              nationalityUsers.add(element.nationality);
            });
            var map = Map();

            nationalityUsers.forEach((element) {
              if (!map.containsKey(element)) {
                map[element] = 1;
              } else {
                map[element] += 1;
              }
            });

            List<ChartData> chartData = [];

            map.forEach((key, value) =>
                chartData.add(ChartData(country: key, count: value)));
            // print(map);
            // print(chartData.map((e) => e.country));

            // // users.forEach((user) {
            // //   user.isVerified == 'Verified' ? verifiedUsers.add(user) : '';
            // // });

            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        // height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(19, 38, 63, 1),
                            border: Border.all(
                                color: Color.fromRGBO(19, 38, 63, 1))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                child: Text('A'),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Dahsboard',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Image.asset(
                                        //   'assets/logo.png',
                                        //   width: 200,
                                        // )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            250, 169, 22, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.group_rounded,
                                                        size: 30.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 8.0, 30.0, 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        users.length.toString(),
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Registered Users',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12.0),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 140, 39, 32),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.assignment,
                                                        size: 30.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 8.0, 30.0, 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: Dashboard()
                                                              .readAllServices(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Text(
                                                                  'Not available');
                                                            } else {
                                                              return Text(
                                                                snapshot
                                                                    .data!.size
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        30.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              );
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Services Requested',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12.0),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: BarChart(
                                            BarChartData(barGroups: [
                                              BarChartGroupData(x: 0, barRods: [
                                                BarChartRodData(toY: 2)
                                              ]),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            controller: ScrollController(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: StreamBuilder<
                                                              List<
                                                                  UserCompleteProfile>>(
                                                          stream: Dashboard()
                                                              .readAllUsers(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return const CircularProgressIndicator();
                                                            } else {
                                                              final user =
                                                                  snapshot
                                                                      .data!;
                                                              return Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: const [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 30.0),
                                                                            child:
                                                                                Text(
                                                                              'Latest Users registered',
                                                                              style: TextStyle(
                                                                                fontSize: 20.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                FittedBox(
                                                                              child: DataTable(
                                                                                headingTextStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
                                                                                columns: const [
                                                                                  DataColumn(label: FittedBox(fit: BoxFit.fitWidth, child: Text('Date'))),
                                                                                  DataColumn(label: FittedBox(fit: BoxFit.fitWidth, child: Text('Email Address'))),
                                                                                  DataColumn(label: FittedBox(fit: BoxFit.fitWidth, child: Text('First Name'))),
                                                                                  DataColumn(label: FittedBox(fit: BoxFit.fitWidth, child: Text('Last Name'))),
                                                                                  // DataColumn(
                                                                                  //     label: Text(
                                                                                  //         '')),
                                                                                ],
                                                                                rows: UserRows().getRowsUsers(user, context),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: StreamBuilder<
                                                              List<
                                                                  ServiceDetails>>(
                                                          stream: Dashboard()
                                                              .readAllServicesNew(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return const CircularProgressIndicator();
                                                            } else {
                                                              final service =
                                                                  snapshot
                                                                      .data!;
                                                              serviceSorted() {
                                                                service.sort((a, b) => b
                                                                    .creationDate
                                                                    .compareTo(a
                                                                        .creationDate));
                                                              }

                                                              serviceSorted();
                                                              return Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: const [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 8.0),
                                                                            child:
                                                                                Text(
                                                                              'Latest Services requested',
                                                                              style: TextStyle(
                                                                                fontSize: 20.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                FittedBox(
                                                                              child: DataTable(
                                                                                headingTextStyle: const TextStyle(
                                                                                  color: Colors.grey,
                                                                                  // fontSize:
                                                                                  //     12.0
                                                                                ),
                                                                                columns: const [
                                                                                  DataColumn(
                                                                                      label: FittedBox(
                                                                                    fit: BoxFit.fitWidth,
                                                                                    child: Text('Date'),
                                                                                  )),
                                                                                  DataColumn(
                                                                                      label: FittedBox(
                                                                                    fit: BoxFit.fitWidth,
                                                                                    child: Text('Service'),
                                                                                  )),
                                                                                  DataColumn(
                                                                                      label: FittedBox(
                                                                                    fit: BoxFit.fitWidth,
                                                                                    child: Text('User'),
                                                                                  )),
                                                                                  DataColumn(
                                                                                      label: FittedBox(
                                                                                    fit: BoxFit.fitWidth,
                                                                                    child: Text('Status'),
                                                                                  )),
                                                                                  // DataColumn(
                                                                                  //     label: Text(
                                                                                  //         '')),
                                                                                ],
                                                                                rows: ServicesClass().getRowsServices(service, context),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [Text('test')],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Active Chats',
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: DatabaseChat().readChats(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return ListView.separated(
                                              itemCount: snapshot.data!.size,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot chat =
                                                    snapshot.data!.docs[index];

                                                return StreamBuilder<
                                                    UserCompleteProfile>(
                                                  stream: DatabaseChat()
                                                      .fetchName(
                                                          chat.get('user')),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const CircularProgressIndicator();
                                                    } else {
                                                      final name = snapshot
                                                          .data!.firstName;
                                                      final isRead =
                                                          chat.get('isRead');
                                                      final user =
                                                          chat.get('user');
                                                      bool lastIsRead = !isRead;
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UserProfilePage(
                                                                      id: user,
                                                                      showNewChatMessage:
                                                                          lastIsRead)));
                                                        },
                                                        child: Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  child: Text(
                                                                      name.split(
                                                                          '')[0]),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8.0,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            4.0,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              name,
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(chat.get('timeLastMessage'))),
                                                                              textAlign: TextAlign.end,
                                                                              style: TextStyle(fontSize: 12.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            3.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              chat.get('textLastMessage'),
                                                                              style: TextStyle(fontSize: 12.0),
                                                                            ),
                                                                          ),
                                                                          isRead
                                                                              ? Text('')
                                                                              : Container(
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    '1',
                                                                                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                                                                                  )),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }
}

class ChartData {
  final String country;
  final int count;

  ChartData({required this.country, required this.count});
}
