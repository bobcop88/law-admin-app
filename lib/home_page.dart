import 'package:adminapp/dashboard/dashboard.dart';
import 'package:adminapp/old_pages/users_home.dart';
import 'package:adminapp/services/services_page.dart';
import 'package:adminapp/users/new_users_pages/users_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  static const List<Widget> _pageSelected = <Widget>[
    DashboardAdmin(),
    UsersNewHome(),
    ServicesPage(),
  ];

  

  @override
  Widget build(BuildContext context) {

    AppBar appBar= AppBar(
      title: Center(child: Text('Admin Portal')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.logout_outlined),
                  onPressed: () {FirebaseAuth.instance.signOut();},
                ),
                Text('Log out'),
              ],
            ),
          ),
        ],
    );



    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: appBar,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: NavigationRail(
                      leading:
                          StreamBuilder(
                            stream: Stream.periodic(Duration(seconds: 1)),
                            builder: (context, snapshot){
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())),
                              );
                            }
                          ),
                        
                      selectedIndex: _selectedIndex,
                      // minWidth: 250.0,
                      backgroundColor: Colors.blueAccent,
                      labelType: NavigationRailLabelType.selected,
                      selectedLabelTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      selectedIconTheme: IconThemeData(
                        color: Colors.white
                      ),
                      unselectedIconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                      onDestinationSelected: (int index){
                        setState(() {
                          _selectedIndex = index;
                          if(_selectedIndex == 0){
                            
                          }
                        });
                      },
                      destinations: [
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
            
          ],
        ),
      ),
    );
    

     
  }
}

