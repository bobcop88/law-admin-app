import 'package:adminapp/users/service_details_page.dart';
import 'package:adminapp/users/user_services.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileDetails extends StatefulWidget {
  final String id;
  const UserProfileDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {

  var serviceName;
  bool updateFullName = false;
  bool updatePhoneNumber = false;
  bool updateIsVerified = false;
  String isVerifiedStatus = 'Verified';

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserProfile>(
      stream: DatabaseUserProfile(uid: widget.id).readUserProfile(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          
          return Center(
            child: Text('Select user to show details'),
          );
        }else{
          final user = snapshot.data!;
          return  DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 50.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'User Profile',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.grey
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          child: Text(
                                            user.fullName.split(' ')[0][0] +  user.fullName.split(' ')[1][0],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Full Name: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        updateFullName ? 
                                        Expanded(
                                          child: TextField(
                                            controller: _fullNameController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'New name',
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(5,10,10,0),
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ) :
                                        Expanded(child: Text(user.fullName)),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updateFullName ? 'Save' : 'Update',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updateFullName ? updateFullName = false : updateFullName = true;
                                              if(updateFullName == false){
                                                DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'fullName', _fullNameController.text.trim());
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updateFullName ? 'Cancel' : '',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updateFullName ? updateFullName = false : updateFullName = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          'Email address: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(child: Text(user.email)),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          'Phone Number: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        updatePhoneNumber ? 
                                        Expanded(
                                          child: TextField(
                                            controller: _phoneNumberController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'New phone number',
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(5,10,10,0),
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ) :
                                        Expanded(child: Text(user.phoneNumber)),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updatePhoneNumber ? 'Save' : 'Update',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updatePhoneNumber ? updatePhoneNumber = false : updatePhoneNumber = true;
                                              if(updatePhoneNumber == false){
                                                DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'phoneNumber', _phoneNumberController.text.trim());
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updatePhoneNumber ? 'Cancel' : '',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updatePhoneNumber ? updatePhoneNumber = false : updatePhoneNumber = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          'Email is Verified: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(FirebaseAuth.instance.currentUser!.emailVerified ? 'Yes' : 'No'),
                                        Icon(
                                          FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Icons.unpublished_outlined : Icons.verified_outlined,
                                          color: FirebaseAuth.instance.currentUser!.emailVerified == 'Yes' ? Colors.red : Colors.green,
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          'Is Verified: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        updateIsVerified ? 
                                        Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: Container(
                                                height: 20.0,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  isDense: false,
                                                  value: isVerifiedStatus,
                                                  style: TextStyle(
                                                    fontSize: 14.0
                                                  ),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      isVerifiedStatus = newValue!;
                                                    });
                                                  },
                                                  items:  
                                                  <String>['Verified', 'Pending', 'Not Verified', 'Rejected']
                                                      .map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) :
                                        Expanded(child: Text(user.isVerified)),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updateIsVerified ? 'Save' : 'Update',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updateIsVerified ? updateIsVerified = false : updateIsVerified = true;
                                              if(updateIsVerified == false){
                                                DatabaseUserProfile(uid: user.id).updateProfileUser(user.id, 'isVerified', isVerifiedStatus);
                                              }
                                            });
                                          },
                                        ),
                                        SizedBox(width: 5.0,),
                                        InkWell(
                                          child: Text( updateIsVerified ? 'Cancel' : '',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              updateIsVerified ? updateIsVerified = false : updateIsVerified = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Active Services',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.grey
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                      child: Divider(
                                        indent: 200.0,
                                        endIndent: 200.0,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<List<ServiceDetails>>(
                                          stream: DatabaseService(uid: user.id).readAllServices(),
                                          builder: (context, snapshot){
                                            if(!snapshot.hasData || snapshot.data!.length == 0){
                                              return Center(child: Text('No Active Services'),);
                                            }else{
                                              final service = snapshot.data!;
                                              return SizedBox(
                                                width: 200.0,
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: snapshot.data!.length,
                                                      itemBuilder: (context, index) {
                                                        return TextButton(
                                                          child: Text(snapshot.data![index].serviceName),
                                                          onPressed: () {
                                                            setState(() {
                                                              serviceName = snapshot.data![index].serviceName;
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                              
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                      child: Divider(
                                        indent: 200.0,
                                        endIndent: 200.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: ServiceSelectedDetails(id: widget.id, serviceName: serviceName)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

