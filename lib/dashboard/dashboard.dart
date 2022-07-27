import 'package:adminapp/services/utils/services_classes.dart';
import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
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
                                            children: const [
                                              Icon(
                                                Icons.group_rounded,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text(
                                                'Registered Users',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              Text(
                                                users.length.toString(),
                                                style: const TextStyle(
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
                              StreamBuilder<List<UserCompleteProfile>>(
                                  stream: DatabaseUsers().readAllUsers(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      final user = snapshot.data!;
                                      return Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'Latest Users registered',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DataTable(
                                                      headingTextStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0),
                                                      columns: const [
                                                        DataColumn(
                                                            label:
                                                                Text('Date')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Email Address')),
                                                        DataColumn(
                                                            label: Text(
                                                                'First Name')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Last Name')),
                                                        DataColumn(
                                                            label: Text('')),
                                                      ],
                                                      rows: UserRows()
                                                          .getRowsUsers(
                                                              user, context),
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
                                  stream: Dashboard().readAllServicesNew(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    } else {
                                      final service = snapshot.data!;
                                      return Container(
                                        margin: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'Latest Services requested',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DataTable(
                                                      headingTextStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0),
                                                      columns: [
                                                        DataColumn(
                                                            label:
                                                                Text('Date')),
                                                        DataColumn(
                                                            label: Text(
                                                                'Service')),
                                                        DataColumn(
                                                            label:
                                                                Text('User')),
                                                        DataColumn(
                                                            label:
                                                                Text('Status')),
                                                        DataColumn(
                                                            label: Text('')),
                                                      ],
                                                      rows: ServicesClass()
                                                          .getRowsServices(
                                                              service, context),
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

                        // Expanded(
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: const [
                        //       AdminColumn(),
                        //     ],
                        //   ),
                        // ),
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
