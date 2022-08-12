import 'package:adminapp/dashboard/dashboard.dart';
import 'package:adminapp/dashboard/logs/log_page.dart';
import 'package:adminapp/old_pages/users_home.dart';
import 'package:adminapp/services/services_page.dart';
import 'package:adminapp/users/users_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 38, 63, 1),
                    border: Border.all(color: Color.fromRGBO(19, 38, 63, 1))),
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
                                style: TextStyle(
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
                                ? Color.fromARGB(46, 54, 102, 165)
                                : Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.home_outlined,
                                        color: Colors.white, size: 18.0),
                                    const SizedBox(
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
                                ? Color.fromARGB(46, 54, 102, 165)
                                : Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.people,
                                        color: Colors.white, size: 18.0),
                                    const SizedBox(
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
                                ? Color.fromARGB(46, 54, 102, 165)
                                : Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.assignment,
                                        color: Colors.white, size: 18.0),
                                    const SizedBox(
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
                                ? Color.fromARGB(46, 54, 102, 165)
                                : Color.fromRGBO(19, 38, 63, 1)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.tune,
                                        color: Colors.white, size: 18.0),
                                    const SizedBox(
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
