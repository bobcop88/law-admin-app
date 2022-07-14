import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String id;
  const UserProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String serviceName = '';
  String userIdChat = '';
  bool _chatVisible = false;

  bool updateFullName = false;
  bool updatePhoneNumber = false;

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserCompleteProfile>(
        stream: DatabaseUserProfile(uid: widget.id).readUserProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final user = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text('Profile ${user.firstName}'),
                ),
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Text((user.firstName.split(' ')[0][0] +
                                      user.lastName.split(' ')[0][0])
                                  .toUpperCase()),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'First Name: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: updateFullName
                                          ? TextField(
                                              autofocus: true,

                                              controller: _fullNameController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Insert first Name',
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        5, 10, 10, 0),
                                                hintStyle: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              // style: const TextStyle(
                                              //   fontSize: 14.0,
                                              // ),
                                            )
                                          : TextField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                hintText: user.firstName,
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 10, 10, 0),
                                                hintStyle: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // style: const TextStyle(
                                              //   fontSize: 14.0,
                                              // ),
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        updateFullName ? 'Save' : 'Update',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          updateFullName
                                              ? updateFullName = false
                                              : updateFullName = true;
                                          if (updateFullName == false) {
                                            DatabaseUserProfile(uid: user.id)
                                                .updateProfileUser(
                                                    user.id,
                                                    'firstName',
                                                    _fullNameController.text
                                                        .trim());
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      child: Text(
                                        updateFullName ? 'Cancel' : '',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          updateFullName
                                              ? updateFullName = false
                                              : updateFullName = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
