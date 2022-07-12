import 'dart:html';

import 'package:adminapp/dashboard/admin_column.dart';
import 'package:adminapp/users/new_users_pages/user_profile_new.dart';
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
            return Center(child: CircularProgressIndicator());
          } else {
            final users = snapshot.data!;

            // users.forEach((user) {
            //   user.isVerified == 'Verified' ? verifiedUsers.add(user) : '';
            // });

            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.group_rounded,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Registered Users',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text(
                                                users.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.verified_rounded,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Verified Users',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
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
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Card(
                                      margin: EdgeInsets.all(20.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Latest Users registered',
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'Email Address',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Name',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: users.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  hoverColor: Colors.grey[200],
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                UserProfileNew(
                                                                    id: users[
                                                                            index]
                                                                        .id))));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                DateFormat(
                                                                        'dd/MM/yy')
                                                                    .format(DateTime.fromMicrosecondsSinceEpoch(
                                                                        users[index]
                                                                            .dateCreation))
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                users[index]
                                                                    .email!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                users[index]
                                                                    .firstName,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Card(
                                      margin: EdgeInsets.all(20.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Latest Services requested',
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Service',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    'User',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Status',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: Dashboard()
                                                    .readAllServices(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return CircularProgressIndicator();
                                                  } else {
                                                    return ListView.separated(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          snapshot.data!.size,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              const Divider(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        DocumentSnapshot
                                                            service = snapshot
                                                                .data!
                                                                .docs[index];
                                                        return InkWell(
                                                          hoverColor:
                                                              Colors.grey[200],
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: ((context) =>
                                                                        UserProfileNew(
                                                                            id: service.get('userId')))));
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        DateFormat('dd MMMM yyyy')
                                                                            .format(DateTime.fromMicrosecondsSinceEpoch(service.get('creationDate'))),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        service
                                                                            .get('serviceName')
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Text(
                                                                        service
                                                                            .get('emailUser')
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Text(
                                                                        service.get(
                                                                            'currentState'),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AdminColumn(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}



// StreamBuilder<QuerySnapshot>(
//                                                   stream: Dashboard().readUsersListDate(),
//                                                   builder: (context, snapshot) {
//                                                     if(!snapshot.hasData){
//                                                       return Center(child: CircularProgressIndicator(),);
//                                                     }else{
                            
//                                                       final user = snapshot.data!;
//                                                       // print(user.docs.length);
                                                      
//                                                       return Expanded(
//                                                         child: Column(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // height: 400.0,
//                                                                     // width: 400.0,
//                                                                     child: ListView(
//                                                                       shrinkWrap: true,
//                                                                       children: snapshot.data!.docs
//                                                                           .map((DocumentSnapshot document) {
//                                                                             Map<String, dynamic> data =
//                                                                                 document.data()! as Map<String, dynamic>;
//                                                                             return Row(
//                                                                               children: [
//                                                                                 Text(
//                                                                                   data['email']
//                                                                                 ),
//                                                                                 SizedBox(width: 5.0,),
//                                                                                 Text(
//                                                                                   DateFormat('dd MMMM yyyy').format(DateTime.fromMicrosecondsSinceEpoch(data['dateCreation']))
//                                                                                 ),
//                                                                               ],
//                                                                             );
                                                                            
//                                                                             // ListTile(
//                                                                             //   title: Text(data['email']),
//                                                                             //   subtitle: Text(DateFormat('dd MMMM yyyy').format(DateTime.fromMicrosecondsSinceEpoch(data['dateCreation']))),
//                                                                             // );
//                                                                           })
//                                                                           .toList()
//                                                                           .cast(),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       );
//                                                     }
//                                                   }
//                                                 )