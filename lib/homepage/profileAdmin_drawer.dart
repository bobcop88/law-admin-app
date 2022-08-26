import 'package:adminapp/dashboard/utils/admin_profile_class.dart';
import 'package:adminapp/login/forgot_password.dart';
import 'package:adminapp/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  bool updateName = false;
  bool updatePhone = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final adminId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profile Admin',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: 20.0,
          ),
          Flexible(
            child: StreamBuilder<Admin>(
              stream: DatabaseAdmin(uid: adminId).readAdminDetails(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  final admin = snapshot.data!;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            child: Text(
                              admin.fullName[0].toUpperCase() +
                                  admin.fullName.split(' ')[1][0].toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            radius: 23,
                            backgroundColor: Color.fromRGBO(19, 38, 63, 1),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Email address: ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(child: Text(admin.emailAddress))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Full Name: ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                      ),
                                      updateName
                                          ? Flexible(
                                              child: TextField(
                                              controller: nameController,
                                              autofocus: true,
                                              style: TextStyle(fontSize: 12.0),
                                              decoration: InputDecoration(
                                                  hintText: 'Enter new name',
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                            ))
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(admin.fullName),
                                            ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      !updateName
                                          ? updateName = true
                                          : updateName = false;
                                    });
                                    if (!updateName &&
                                        nameController.text.trim().isNotEmpty) {
                                      DatabaseAdmin(uid: adminId).updateAdmin(
                                          'fullName',
                                          nameController.text.trim());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      updateName ? 'Save' : 'Change',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.blue),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      !updateName
                                          ? updateName = true
                                          : updateName = false;
                                      nameController.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      updateName ? 'Cancel' : '',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Phone number: ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                      ),
                                      updatePhone
                                          ? Flexible(
                                              child: TextField(
                                              controller: phoneController,
                                              autofocus: true,
                                              style: TextStyle(fontSize: 12.0),
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Enter new phone number',
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                            ))
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(admin.phoneNumber),
                                            ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      !updatePhone
                                          ? updatePhone = true
                                          : updatePhone = false;
                                    });
                                    if (!updatePhone &&
                                        phoneController.text
                                            .trim()
                                            .isNotEmpty) {
                                      DatabaseAdmin(uid: adminId).updateAdmin(
                                          'phoneNumber',
                                          phoneController.text.trim());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      updatePhone ? 'Save' : 'Change',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.blue),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      !updatePhone
                                          ? updatePhone = true
                                          : updatePhone = false;
                                      phoneController.clear();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      updatePhone ? 'Cancel' : '',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                                },
                                child: Text('Reset password'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 18.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Log out',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
