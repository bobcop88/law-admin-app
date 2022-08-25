import 'package:adminapp/dashboard/dashboard.dart';
import 'package:adminapp/dashboard/utils/admin_profile_class.dart';
import 'package:adminapp/homepage/endDrawerNotifications.dart';
import 'package:adminapp/logs/log_page.dart';
import 'package:adminapp/services/services_page.dart';
import 'package:adminapp/users/users_list_page.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/notifications/notifications_class.dart';
import 'package:adminapp/utils/notifications/notifications_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _pageSelected = [
    DashboardAdmin(),
    UsersListPage(),
    ServicesPage(),
    LogsPage(),
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: scaffoldKey,
      endDrawer: const EndDrawerNotifications(),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(19, 38, 63, 1),
                    border:
                        Border.all(color: const Color.fromRGBO(19, 38, 63, 1))),
                // width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/logo.png',
                              color: Colors.white,
                              // height: 70,
                              // width: 200,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Text(
                                DateFormat('dd-MM-yyyy HH:mm:ss')
                                    .format(DateTime.now()),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? const Color.fromARGB(46, 54, 102, 165)
                                : const Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.home_outlined,
                                        color: Colors.white, size: 18.0),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Dashboard',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _selectedIndex == 1
                                ? const Color.fromARGB(46, 54, 102, 165)
                                : const Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.people,
                                        color: Colors.white, size: 18.0),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Users',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _selectedIndex == 2
                                ? const Color.fromARGB(46, 54, 102, 165)
                                : const Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.assignment,
                                        color: Colors.white, size: 18.0),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Services',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: _selectedIndex == 3
                                ? const Color.fromARGB(46, 54, 102, 165)
                                : const Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.tune,
                                        color: Colors.white, size: 18.0),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Logs',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: StreamBuilder<List<NotificationsUserToAdmin>>(
                          stream: NotificationsFromUsers()
                              .readNotificationsFromUsers(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              bool hasNew = false;
                              for (var element in snapshot.data!) {
                                element.isNew == true ? hasNew = true : false;
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: hasNew
                                              ? Colors.white
                                              : Color.fromRGBO(19, 38, 63, 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.notifications,
                                                color: hasNew
                                                    ? Color.fromRGBO(
                                                        19, 38, 63, 1)
                                                    : Colors.white,
                                                size: 18.0),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              'Notifications',
                                              style: TextStyle(
                                                  color: hasNew
                                                      ? Color.fromRGBO(
                                                          19, 38, 63, 1)
                                                      : Colors.white),
                                            ),
                                            const Spacer(),
                                            hasNew
                                                ? const Text(
                                                    'New',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
                    const Spacer(),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'You are logged as:',
                          style: TextStyle(fontSize: 11.0, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<Admin>(
                        stream: DatabaseAdmin(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .readAdminDetails(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            final admin = snapshot.data!;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      child: Text(
                                        admin.fullName[0].toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(19, 38, 63, 1)),
                                      ),
                                      radius: 23,
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        admin.emailAddress,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      19, 38, 63, 1)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.white)))),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            size: 18.0,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Log out',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30.0,
                                )
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: _pageSelected.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
