// import 'package:adminapp/users/user_services.dart';
// import 'package:adminapp/utils/database.dart';
// import 'package:adminapp/utils/service_details.dart';
// import 'package:adminapp/utils/users_profile_class.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class UserProfileDetails extends StatefulWidget {
//   final String id;
//   const UserProfileDetails({Key? key, required this.id}) : super(key: key);

//   @override
//   State<UserProfileDetails> createState() => _UserProfileDetailsState();
// }

// class _UserProfileDetailsState extends State<UserProfileDetails> {

//   var service;
//   var serviceName;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<UserProfile>(
//       stream: DatabaseUserProfile(uid: widget.id).readUserProfile(),
//       builder: (context,snapshot){
//         if(!snapshot.hasData){
          
//           return Center(
//             child: Text('Select user to show details'),
//           );
//         }else{
//           final user = snapshot.data!;
//           return  Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                   ),
//                   padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   CircleAvatar(
//                                     child: Text(
//                                       user.fullName.split(' ')[0][0] +  user.fullName.split(' ')[1][0],
//                                     ),
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Full Name: ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Text(user.fullName),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Email address: ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Text(user.email),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Phone number: ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Text(user.phoneNumber),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Email is Verified: ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Text(FirebaseAuth.instance.currentUser!.emailVerified ? 'Yes' : 'No'),
//                                       Icon(
//                                         FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Icons.unpublished_outlined : Icons.verified_outlined,
//                                         color: FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Colors.red : Colors.green,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Is Verified: ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Text(user.isVerified),
//                                     ],
//                                   ),
//                                   SizedBox(height: 20.0,),
//                                   ElevatedButton(
//                                     child: Text('Modify Profile'),
//                                     onPressed: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context){
//                                           return ModifyProfileWindow(id: user.id, fullName: user.fullName, isVerified: user.isVerified);
//                                         }
//                                       );
//                                     },
//                                   ),
//                                   Divider(),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text('Active Services'),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       StreamBuilder<List<ServiceDetails>>(
//                                         stream: DatabaseService(uid: user.id).readAllServices(),
//                                         builder: (context, snapshot){
//                                           if(!snapshot.hasData || snapshot.data!.length == 0){
//                                             return Center(child: Text('No Active Services'),);
//                                           }else{
//                                             // final service = snapshot.data!;
//                                             return SizedBox(
//                                               width: 200.0,
//                                               child: Column(
//                                                 children: [
//                                                   ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount: snapshot.data!.length,
//                                                     itemBuilder: (context, index) {
//                                                       return TextButton(
//                                                         child: Text(snapshot.data![index].serviceName),
//                                                         onPressed: () {
//                                                           setState(() {
//                                                             service = snapshot.data!;
//                                                             serviceName = snapshot.data![index].serviceName;
//                                                           });
//                                                         },
//                                                       );
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
                                            
//                                           }
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
                            
                            
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
          
//         }
//       },
//     );
    
//   }
// }



// class ModifyProfileWindow extends StatefulWidget {
//   final String id;
//   final String fullName;
//   final String isVerified;
//   const ModifyProfileWindow({Key? key, required this.id, required this.fullName, required this.isVerified}) : super(key: key);

//   @override
//   State<ModifyProfileWindow> createState() => _ModifyProfileWindowState();
// }

// class _ModifyProfileWindowState extends State<ModifyProfileWindow> {

//   final _phoneController = TextEditingController();
//   final _isVerifiedController = TextEditingController();
//   String isVerifiedStatus = 'Verified';

    

//   @override 
//   void dispose() {
//     _phoneController.dispose();
//     _isVerifiedController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
     
//       return AlertDialog(
//         title: Text('Modify Profile ${widget.fullName}'),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Phone Number',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                 labelText: 'Change Phone Number',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10.0,),
//             Text(
//               'Is Verified Status',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             Container(
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 value: isVerifiedStatus,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     isVerifiedStatus = newValue!;
//                   });
//                 },
//                 items:  
//                  <String>['Verified', 'Pending', 'Not Verified', 'Rejected']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 20.0,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   child: Text('Modify'),
//                   onPressed: () {
//                     DatabaseUserProfile(uid: widget.id).updateProfileUser(widget.id, _phoneController.text.trim(), isVerifiedStatus);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 SizedBox(width: 5.0,),
//                 ElevatedButton(
//                   child: Text('Cancel'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
                
//               ],
//             ),
//           ],
//         ),
//       );
    
    
//   }
// }