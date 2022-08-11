import 'package:adminapp/dashboard/widgets/buildChatsDashboard.dart';
import 'package:adminapp/services/utils/services_classes.dart';
import 'package:adminapp/users/user_profile_page.dart';
import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/chat_message_class.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserCompleteProfile>>(
        stream: DatabaseUsers().readAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final users = snapshot.data!;

            // users.forEach((user) {
            //   user.isVerified == 'Verified' ? verifiedUsers.add(user) : '';
            // });

            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  // elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.verified_rounded,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              'Verified Users',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       verifiedUsers.length.toString(),
                                        //       style: TextStyle(
                                        //         fontSize: 20.0,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView(
                                        children: [
                                          StreamBuilder<
                                                  List<UserCompleteProfile>>(
                                              stream:
                                                  Dashboard().readAllUsers(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const CircularProgressIndicator();
                                                } else {
                                                  final user = snapshot.data!;
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // boxShadow: [
                                                      //   BoxShadow(
                                                      //     color: Colors.grey
                                                      //         .withOpacity(0.5),
                                                      //     spreadRadius: 5,
                                                      //     blurRadius: 7,
                                                      //     offset: const Offset(
                                                      //         0,
                                                      //         3), // changes position of shadow
                                                      //   ),
                                                      // ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: const [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            30.0),
                                                                child: Text(
                                                                  'Latest Users registered',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    DataTable(
                                                                  headingTextStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12.0),
                                                                  columns: const [
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Date')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Email Address')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'First Name')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Last Name')),
                                                                    // DataColumn(
                                                                    //     label: Text(
                                                                    //         '')),
                                                                  ],
                                                                  rows: UserRows()
                                                                      .getRowsUsers(
                                                                          user,
                                                                          context),
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
                                          StreamBuilder<List<ServiceDetails>>(
                                              stream: Dashboard()
                                                  .readAllServicesNew(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const CircularProgressIndicator();
                                                } else {
                                                  final service =
                                                      snapshot.data!;
                                                  serviceSorted() {
                                                    service.sort((a, b) => b
                                                        .creationDate
                                                        .compareTo(
                                                            a.creationDate));
                                                  }

                                                  serviceSorted();
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: const [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  'Latest Services requested',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    DataTable(
                                                                  headingTextStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12.0),
                                                                  columns: const [
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Date')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Service')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'User')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Status')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            '')),
                                                                  ],
                                                                  rows: ServicesClass()
                                                                      .getRowsServices(
                                                                          service,
                                                                          context),
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [const Text('data')],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Active Chats',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Expanded(
                        //   child: StreamBuilder<List<LastChatMessage>>(
                        //       stream: DatabaseChat().readAllChats(),
                        //       builder: (context, snapshot) {
                        //         if (!snapshot.hasData) {
                        //           return CircularProgressIndicator();
                        //         } else {
                        //           final chat = snapshot.data!;
                        //           print('works');
                        //           return ListView(
                        //             children: chat
                        //                 .map(BuildChats().buildChats)
                        //                 .toList(),
                        //           );
                        //         }
                        //       }),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: DatabaseChat().readChats(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListView.separated(
                                  itemCount: snapshot.data!.size,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot chat =
                                        snapshot.data!.docs[index];

                                    return StreamBuilder<UserCompleteProfile>(
                                      stream: DatabaseChat()
                                          .fetchName(chat.get('user')),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          final name = snapshot.data!.firstName;
                                          final isRead = chat.get('isRead');
                                          final user = chat.get('user');
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfilePage(
                                                            id: user,
                                                            showNewChatMessage:
                                                                true,
                                                          )));
                                            },
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      child: Text(
                                                          name.split('')[0]),
                                                    ),
                                                    const SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 4.0,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                name,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  DateFormat(
                                                                          'HH:mm')
                                                                      .format(DateTime.fromMicrosecondsSinceEpoch(
                                                                          chat.get(
                                                                              'timeLastMessage'))),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.0),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 3.0,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                chat.get(
                                                                    'textLastMessage'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                              isRead
                                                                  ? Text('')
                                                                  : Container(
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .red,
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      child: Center(
                                                                          child: Text(
                                                                        '1',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            color:
                                                                                Colors.white),
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
            );
            // Column(
            //   children: [
            //     Expanded(
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Text('Dashboard'),
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Card(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(15.0),
            //                         child: Column(
            //                           mainAxisSize: MainAxisSize.max,
            //                           children: [
            //                             Row(
            //                               children: const [
            //                                 Icon(
            //                                   Icons.group_rounded,
            //                                 ),
            //                               ],
            //                             ),
            //                             Row(
            //                               children: const [
            //                                 Text(
            //                                   'Registered Users',
            //                                   style: TextStyle(
            //                                     fontSize: 17.0,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                             const Divider(),
            //                             Row(
            //                               children: [
            //                                 Text(
            //                                   users.length.toString(),
            //                                   style: const TextStyle(
            //                                     fontSize: 20.0,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Card(
            //                       child: StreamBuilder<
            //                               List<UserCompleteProfile>>(
            //                           stream: Dashboard().readAllUsers(),
            //                           builder: (context, snapshot) {
            //                             if (!snapshot.hasData) {
            //                               return const CircularProgressIndicator();
            //                             } else {
            //                               final user = snapshot.data!;
            //                               return Container(
            //                                 margin: const EdgeInsets.all(20),
            //                                 decoration: BoxDecoration(
            //                                   color: Colors.white,
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                   boxShadow: [
            //                                     BoxShadow(
            //                                       color: Colors.grey
            //                                           .withOpacity(0.5),
            //                                       spreadRadius: 5,
            //                                       blurRadius: 7,
            //                                       offset: const Offset(0,
            //                                           3), // changes position of shadow
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 child: Padding(
            //                                   padding: const EdgeInsets.only(
            //                                       top: 10.0),
            //                                   child: SizedBox(
            //                                     height: 500,
            //                                     width: 500,
            //                                     child: Column(
            //                                       children: [
            //                                         Row(
            //                                           children: const [
            //                                             Padding(
            //                                               padding:
            //                                                   EdgeInsets.only(
            //                                                       left: 8.0),
            //                                               child: Text(
            //                                                 'Latest Users registered',
            //                                                 style: TextStyle(
            //                                                   fontSize: 20.0,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .bold,
            //                                                 ),
            //                                                 textAlign:
            //                                                     TextAlign.start,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         Expanded(
            //                                           child: Row(
            //                                             children: [
            //                                               Expanded(
            //                                                 child: DataTable(
            //                                                   headingTextStyle:
            //                                                       const TextStyle(
            //                                                           color: Colors
            //                                                               .grey,
            //                                                           fontSize:
            //                                                               12.0),
            //                                                   columns: const [
            //                                                     DataColumn(
            //                                                         label: Text(
            //                                                             'Date')),
            //                                                     DataColumn(
            //                                                         label: Text(
            //                                                             'Email Address')),
            //                                                     DataColumn(
            //                                                         label: Text(
            //                                                             'First Name')),
            //                                                     DataColumn(
            //                                                         label: Text(
            //                                                             'Last Name')),
            //                                                     DataColumn(
            //                                                         label: Text(
            //                                                             '')),
            //                                                   ],
            //                                                   rows: UserRows()
            //                                                       .getRowsUsers(
            //                                                           user,
            //                                                           context),
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               );
            //                             }
            //                           }),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // );
          }
        });
  }
}

// Row(
//                   children: const [
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     Text(
//                       'Dashboard',
//                       style: TextStyle(
//                         fontSize: 17.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),

//                     // Expanded(
//                     //   child: Column(
//                     //     mainAxisSize: MainAxisSize.max,
//                     //     mainAxisAlignment: MainAxisAlignment.start,
//                     //     children: const [
//                     //       AdminColumn(),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: const [
//                                 Icon(
//                                   Icons.verified_rounded,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Text(
//                                   'Verified Users',
//                                   style: TextStyle(
//                                     fontSize: 17.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Divider(),
//                             // Row(
//                             //   children: [
//                             //     Text(
//                             //       verifiedUsers.length.toString(),
//                             //       style: TextStyle(
//                             //         fontSize: 20.0,
//                             //         fontWeight: FontWeight.bold,
//                             //       ),
//                             //     ),
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               StreamBuilder<List<UserCompleteProfile>>(
//                                   stream: Dashboard().readAllUsers(),
//                                   builder: (context, snapshot) {
//                                     if (!snapshot.hasData) {
//                                       return const CircularProgressIndicator();
//                                     } else {
//                                       final user = snapshot.data!;
//                                       return Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.all(20),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 5,
//                                                 blurRadius: 7,
//                                                 offset: const Offset(0,
//                                                     3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 10.0),
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: const [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: 8.0),
//                                                       child: Text(
//                                                         'Latest Users registered',
//                                                         style: TextStyle(
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.start,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: DataTable(
//                                                         headingTextStyle:
//                                                             const TextStyle(
//                                                                 color:
//                                                                     Colors.grey,
//                                                                 fontSize: 12.0),
//                                                         columns: const [
//                                                           DataColumn(
//                                                               label:
//                                                                   Text('Date')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Email Address')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'First Name')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Last Name')),
//                                                           DataColumn(
//                                                               label: Text('')),
//                                                         ],
//                                                         rows: UserRows()
//                                                             .getRowsUsers(
//                                                                 user, context),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                   }),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               StreamBuilder<List<ServiceDetails>>(
//                                   stream: Dashboard().readAllServicesNew(),
//                                   builder: (context, snapshot) {
//                                     if (!snapshot.hasData) {
//                                       return const CircularProgressIndicator();
//                                     } else {
//                                       final service = snapshot.data!;
//                                       serviceSorted() {
//                                         service.sort((a, b) => b.creationDate
//                                             .compareTo(a.creationDate));
//                                       }

//                                       serviceSorted();
//                                       return Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.all(20),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 5,
//                                                 blurRadius: 7,
//                                                 offset: const Offset(0,
//                                                     3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 10.0),
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: const [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: 8.0),
//                                                       child: Text(
//                                                         'Latest Services requested',
//                                                         style: TextStyle(
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.start,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: DataTable(
//                                                         headingTextStyle:
//                                                             const TextStyle(
//                                                                 color:
//                                                                     Colors.grey,
//                                                                 fontSize: 12.0),
//                                                         columns: const [
//                                                           DataColumn(
//                                                               label:
//                                                                   Text('Date')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Service')),
//                                                           DataColumn(
//                                                               label:
//                                                                   Text('User')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Status')),
//                                                           DataColumn(
//                                                               label: Text('')),
//                                                         ],
//                                                         rows: ServicesClass()
//                                                             .getRowsServices(
//                                                                 service,
//                                                                 context),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                   }),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

// Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 StreamBuilder<List<ServiceDetails>>(
//                                     stream: Dashboard().readAllServicesNew(),
//                                     builder: (context, snapshot) {
//                                       if (!snapshot.hasData) {
//                                         return const CircularProgressIndicator();
//                                       } else {
//                                         final service = snapshot.data!;
//                                         serviceSorted() {
//                                           service.sort((a, b) => b.creationDate
//                                               .compareTo(a.creationDate));
//                                         }

//                                         serviceSorted();
//                                         return Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10.0),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: const [
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: 8.0),
//                                                     child: Text(
//                                                       'Latest Services requested',
//                                                       style: TextStyle(
//                                                         fontSize: 20.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                       textAlign:
//                                                           TextAlign.start,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: DataTable(
//                                                       headingTextStyle:
//                                                           const TextStyle(
//                                                               color:
//                                                                   Colors.grey,
//                                                               fontSize: 12.0),
//                                                       columns: const [
//                                                         DataColumn(
//                                                             label:
//                                                                 Text('Date')),
//                                                         DataColumn(
//                                                             label: Text(
//                                                                 'Service')),
//                                                         DataColumn(
//                                                             label:
//                                                                 Text('User')),
//                                                         DataColumn(
//                                                             label:
//                                                                 Text('Status')),
//                                                         DataColumn(
//                                                             label: Text('')),
//                                                       ],
//                                                       rows: ServicesClass()
//                                                           .getRowsServices(
//                                                               service, context),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }
//                                     }),
//                                 StreamBuilder<List<ServiceDetails>>(
//                                     stream: Dashboard().readAllServicesNew(),
//                                     builder: (context, snapshot) {
//                                       if (!snapshot.hasData) {
//                                         return const CircularProgressIndicator();
//                                       } else {
//                                         final service = snapshot.data!;
//                                         // serviceSorted() {
//                                         //   service.sort((a, b) => b.creationDate
//                                         //       .compareTo(a.creationDate));
//                                         // }

//                                         // serviceSorted();
//                                         return Container(
//                                           margin: const EdgeInsets.all(20),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 5,
//                                                 blurRadius: 7,
//                                                 offset: const Offset(0,
//                                                     3), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 10.0),
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: const [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: 8.0),
//                                                       child: Text(
//                                                         'Latest Services requested',
//                                                         style: TextStyle(
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.start,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: DataTable(
//                                                         headingTextStyle:
//                                                             const TextStyle(
//                                                                 color:
//                                                                     Colors.grey,
//                                                                 fontSize: 12.0),
//                                                         columns: const [
//                                                           DataColumn(
//                                                               label:
//                                                                   Text('Date')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Service')),
//                                                           DataColumn(
//                                                               label:
//                                                                   Text('User')),
//                                                           DataColumn(
//                                                               label: Text(
//                                                                   'Status')),
//                                                           DataColumn(
//                                                               label: Text('')),
//                                                         ],
//                                                         rows: ServicesClass()
//                                                             .getRowsServices(
//                                                                 service,
//                                                                 context),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     }),
//                               ],
//                             ),
