import 'package:adminapp/dashboard/utils/admin_profile_class.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AdminColumn extends StatefulWidget {
  const AdminColumn({Key? key}) : super(key: key);

  @override
  State<AdminColumn> createState() => _AdminColumnState();
}

class _AdminColumnState extends State<AdminColumn> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout_outlined,
                                  ),
                                  Text('Log out'),
                                ],
                              ),
                              onPressed: () {FirebaseAuth.instance.signOut();},
                            ),
                          ),
                          SizedBox(height: 30.0,),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<Admin>(
                        stream: DatabaseAdmin(uid: FirebaseAuth.instance.currentUser!.uid.toString()).readAdminDetails(),
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator(),);
                          }else{
                            final admin = snapshot.data!;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Text(admin.fullName.split(' ')[0][0]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0,),
                                Row(
                                  children: [
                                    Text(
                                      admin.fullName,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                  admin.roleUser,
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      ),
                      
                    ],
                  ),

                  Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseChat().readChats(),
                          builder: (context, snapshot){
                            // print(snapshot.data);
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator(),);
                            }else{

                              return ListView.separated(
                                itemCount: snapshot.data!.size,
                                shrinkWrap: true,
                                separatorBuilder: (BuildContext context, int index) => const Divider(),
                                itemBuilder: (context, index){
                                  DocumentSnapshot chat = snapshot.data!.docs[index];

                                  return StreamBuilder<UserProfile>(
                                    stream: DatabaseChat().fetchName(chat.get('user')),
                                    builder: (context, snapshot){
                                      if(!snapshot.hasData){
                                        return CircularProgressIndicator();
                                      }else{
                                        final name = snapshot.data!.fullName;
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              child: Text(name.split('')[0]),
                                            ),
                                            SizedBox(width: 8.0,),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 4.0,),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        name,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 3.0,),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        chat.get('senderLastMessage') == chat.get('user') ? '' : 'You: '
                                                      ),
                                                      
                                                      Text(chat.get('textLastMessage')),
                                                      Expanded(
                                                        child: Text(
                                                          DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(chat.get('timeLastMessage'))),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
          ],
        ),
      ),
    );
    
  }
}