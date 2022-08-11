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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 38, 63, 1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              color: Colors.white,
              // height: 70,
              width: 200,
            ),
            Row(
              children: [
                Icon(CupertinoIcons.bell),
                const SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  child: Text('AC'),
                ),
                SizedBox(
                  width: 50,
                )
              ],
            ),
          ],
        ),
        actions: [
          Row(
            children: [Icon(Icons.logout_outlined)],
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: NavigationRail(
                leading: Column(
                  children: [
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  DateFormat('dd-MM-yyyy\nHH:mm:ss')
                                      .format(DateTime.now()),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 200),
                  ],
                ),

                selectedIndex: _selectedIndex,
                // minWidth: 250.0,
                backgroundColor: Color.fromRGBO(19, 38, 63, 1),
                labelType: NavigationRailLabelType.selected,
                selectedLabelTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 20.0),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    if (_selectedIndex == 0) {}
                  });
                },
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.home,
                      size: 30.0,
                    ),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.groups,
                      size: 30.0,
                    ),
                    label: Text('Users'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.verified_user_outlined),
                    label: Text('Services'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.folder_zip),
                    label: Text('Logs'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: _pageSelected.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
