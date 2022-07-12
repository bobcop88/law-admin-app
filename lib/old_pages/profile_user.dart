// import 'package:adminapp/utils/database.dart';
// import 'package:flutter/material.dart';


// class ProfileUser extends StatefulWidget {
//   final String user;
//   final String id;
//   const ProfileUser({Key? key,required this.id, required this.user) : super(key: key);

//   @override
//   State<ProfileUser> createState() => _ProfileUserState();
// }

// class _ProfileUserState extends State<ProfileUser> {
//   @override
//   Widget build(BuildContext context) {

//     bool updateFullName = false;
//     bool updatePhoneNumber = false;
//     bool updateIsVerified = false;
//     String isVerifiedStatus = 'Verified';

//     final _fullNameController = TextEditingController();
//     final _phoneNumberController = TextEditingController();

//     return Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 50.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'User Profile',
//                                           style: TextStyle(
//                                             fontSize: 20.0,
//                                             color: Colors.grey
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 20.0,),
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           child: Text(
//                                             widget.user.fullName.split(' ')[0][0] +  widget.user.fullName.split(' ')[1][0],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 20.0),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Full Name: ',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         updateFullName ? 
//                                         Expanded(
//                                           child: TextField(
//                                             controller: _fullNameController,
//                                             decoration: InputDecoration(
//                                               border: OutlineInputBorder(),
//                                               hintText: 'New name',
//                                               isDense: true,
//                                               contentPadding: EdgeInsets.fromLTRB(5,10,10,0),
//                                               hintStyle: TextStyle(
//                                                 fontSize: 14.0,
//                                               ),
//                                             ),
//                                             style: TextStyle(
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                         ) :
//                                         Expanded(child: Text(widget.user.fullName)),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updateFullName ? 'Save' : 'Update',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updateFullName ? updateFullName = false : updateFullName = true;
//                                               if(updateFullName == false){
//                                                 DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'fullName', _fullNameController.text.trim());
//                                               }
//                                             });
//                                           },
//                                         ),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updateFullName ? 'Cancel' : '',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updateFullName ? updateFullName = false : updateFullName = true;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     Divider(),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Email address: ',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         Expanded(child: Text(user.email)),
//                                       ],
//                                     ),
//                                     Divider(),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Phone Number: ',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         updatePhoneNumber ? 
//                                         Expanded(
//                                           child: TextField(
//                                             controller: _phoneNumberController,
//                                             decoration: InputDecoration(
//                                               border: OutlineInputBorder(),
//                                               hintText: 'New phone number',
//                                               isDense: true,
//                                               contentPadding: EdgeInsets.fromLTRB(5,10,10,0),
//                                               hintStyle: TextStyle(
//                                                 fontSize: 14.0,
//                                               ),
//                                             ),
//                                             style: TextStyle(
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                         ) :
//                                         Expanded(child: Text(user.phoneNumber)),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updatePhoneNumber ? 'Save' : 'Update',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updatePhoneNumber ? updatePhoneNumber = false : updatePhoneNumber = true;
//                                               if(updatePhoneNumber == false){
//                                                 DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'phoneNumber', _phoneNumberController.text.trim());
//                                               }
//                                             });
//                                           },
//                                         ),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updatePhoneNumber ? 'Cancel' : '',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updatePhoneNumber ? updatePhoneNumber = false : updatePhoneNumber = true;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     Divider(),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Email is Verified: ',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         Text(FirebaseAuth.instance.currentUser!.emailVerified ? 'Yes' : 'No'),
//                                         Icon(
//                                           FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Icons.unpublished_outlined : Icons.verified_outlined,
//                                           color: FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Colors.red : Colors.green,
//                                         ),
//                                       ],
//                                     ),
//                                     Divider(),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Is Verified: ',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         updateIsVerified ? 
//                                         Expanded(
//                                           child: DropdownButtonHideUnderline(
//                                             child: ButtonTheme(
//                                               alignedDropdown: true,
//                                               child: Container(
//                                                 height: 20.0,
//                                                 child: DropdownButton<String>(
//                                                   isExpanded: true,
//                                                   isDense: false,
//                                                   value: isVerifiedStatus,
//                                                   style: TextStyle(
//                                                     fontSize: 14.0
//                                                   ),
//                                                   onChanged: (String? newValue) {
//                                                     setState(() {
//                                                       isVerifiedStatus = newValue!;
//                                                     });
//                                                   },
//                                                   items:  
//                                                   <String>['Verified', 'Pending', 'Not Verified', 'Rejected']
//                                                       .map<DropdownMenuItem<String>>((String value) {
//                                                     return DropdownMenuItem<String>(
//                                                       value: value,
//                                                       child: Text(
//                                                         value,
//                                                         style: TextStyle(
//                                                           fontSize: 14.0,
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ) :
//                                         Expanded(child: Text(user.isVerified)),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updateIsVerified ? 'Save' : 'Update',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updateIsVerified ? updateIsVerified = false : updateIsVerified = true;
//                                               if(updateIsVerified == false){
//                                                 DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'isVerified', isVerifiedStatus);
//                                               }
//                                             });
//                                           },
//                                         ),
//                                         SizedBox(width: 5.0,),
//                                         InkWell(
//                                           child: Text( updateIsVerified ? 'Cancel' : '',
//                                             style: TextStyle(
//                                               color: Colors.blueAccent,
//                                               fontSize: 14.0,
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             setState(() {
//                                               updateIsVerified ? updateIsVerified = false : updateIsVerified = true;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
    
//   }
// }