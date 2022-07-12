// import 'dart:html';

// import 'package:adminapp/users/user_profile_details.dart';
// import 'package:adminapp/utils/database.dart';
// import 'package:adminapp/utils/users_profile_class.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';


// class UserHome extends StatefulWidget {
//   const UserHome({Key? key}) : super(key: key);

//   @override
//   State<UserHome> createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {

//   final _userController = TextEditingController();
//   String _searchUser = '';
//   var userId;

//   @override
//   Widget build(BuildContext context) {

//     return StreamBuilder<List<UserProfile>>(
//       stream: DatabaseUsers().readAllUsers(),
//       builder: (context, snapshot) {
//         if(!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }else{

//           List users = [];

//           if(_searchUser.length > 0){
//             users = snapshot.data!.where((element) {
//               return element.fullName.toLowerCase().contains(_searchUser.toLowerCase()) ||
//                       element.email.toLowerCase().contains(_searchUser.toLowerCase());
//             }).toList();
//           }
//           else{
//             users = snapshot.data!;
//           }
//           return  Column(
//             children: [
//               Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: Drawer(
//                         elevation: 5.0,
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
//                                     child: Text(
//                                       'List of User',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20.0,),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left:2.0, right: 2.0),
//                                     child: TextField(
//                                       controller: _userController,
//                                       style: TextStyle(
//                                         fontSize: 15.0,
//                                       ),
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         contentPadding: EdgeInsets.fromLTRB(5.0,5.0,5.0,0),
//                                         prefixIcon:  Icon(Icons.search_outlined),
//                                         hintText: 'Search User',
//                                         border: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Colors.blueAccent,
//                                           ),
//                                         ),
//                                       ),
//                                       onChanged: (value) {
//                                         setState(() {
//                                         _searchUser = value;
//                                         });
//                                       },
                                      
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.0,),
//                             Divider(
//                               indent: 100.0,
//                               endIndent: 100.0,
//                             ),
//                             SizedBox(height: 10.0,),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: ListView.builder(
//                                       padding: EdgeInsets.zero,
//                                       itemCount: users.length,
//                                       itemBuilder: (context, index){
//                                           return InkWell(
//                                             hoverColor: Colors.grey[200],
//                                             onTap: () {
//                                               setState(() {
//                                                 userId = users[index].id;
//                                               });
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border(
//                                                   bottom: BorderSide(
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Text(
//                                                               users[index].email,
//                                                               style: TextStyle(
//                                                                 color: Colors.blueAccent,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             users[index].fullName,
//                                                             textAlign: TextAlign.left,
//                                                             style: TextStyle(
//                                                               color: Colors.grey
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                           );
//                                         }
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: UserProfileDetails(id: userId),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
            
        
//         }
//       }
//     );
    
//   }

  
// }




