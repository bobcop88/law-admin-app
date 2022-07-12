import 'package:adminapp/services/services_details_page.dart';
import 'package:adminapp/users/new_users_pages/user_profile_new.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  final _userController = TextEditingController();
  String _searchUser = '';
  var service;
  var userId;

  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: Dashboard().readAllServices(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          List users = [];

          if(_searchUser.length > 0){
            users = snapshot.data!.docs.where((element) {
              return element['serviceName'].toLowerCase().contains(_searchUser.toLowerCase()) ||
                      element['emailUser'].toLowerCase().contains(_searchUser.toLowerCase());
            }).toList();
          }
          else{
            users = snapshot.data!.docs;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 40.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Services List',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                children: [
                                  SizedBox(
                                    width: 300.0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left:2.0, right: 2.0),
                                      child: TextField(
                                        controller: _userController,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.fromLTRB(5.0,5.0,5.0,0),
                                          prefixIcon:  Icon(Icons.search_outlined),
                                          hintText: 'Search Service',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                          _searchUser = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text('Email Address'),
                                              ),
                                              Expanded(
                                                child: Text('Name'),
                                              ),
                                              Expanded(
                                                child: Text('Date Creation'),
                                              ),
                                              Expanded(
                                                child: Text('Status'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (context, index){
                                        DocumentSnapshot service = snapshot.data!.docs[index];
                                          return InkWell(
                                          hoverColor: Colors.grey[200],
                                          onTap: () {
                                            setState(() {
                                              userId = service.get('userId');
                                              
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileNew(id: userId)));
                                            });
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            service.get('emailUser').toString(),
                                                            style: TextStyle(
                                                              color: Colors.blueAccent,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            service.get('serviceName').toString(),
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            DateFormat('dd MMMM yyyy').format(DateTime.fromMicrosecondsSinceEpoch(service.get('creationDate'))),
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            service.get('currentState').toString(),
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      }
    );
  }
}


   // ListView(
                                    //   shrinkWrap: true,
                                    //   children: snapshot.data!.docs
                                    //   .map((DocumentSnapshot document) {
                                    //     Map<String, dynamic> data =
                                    //         document.data()! as Map<String, dynamic>;
                                    //     return InkWell(
                                    //       hoverColor: Colors.grey[200],
                                    //       onTap: () {},
                                    //       child: Padding(
                                    //         padding: EdgeInsets.all(8.0),
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Row(
                                    //               children: [
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     data['emailUser']
                                    //                   ),
                                    //                 ),
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     data['serviceName']
                                    //                   ),
                                    //                 ),
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     // data['creationDate']
                                    //                     DateFormat('dd/MM/yy').format(DateTime.fromMicrosecondsSinceEpoch(data['creationDate'])).toString()
                                    //                   ),
                                    //                 ),
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     data['currentState']
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   })
                                    //   .toList()
                                    //   .cast(),
                                    // ),