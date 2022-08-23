import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _userController = TextEditingController();
  String _searchUser = '';
  bool isAscending = false;
  int? sortColumnIndex;
  List<UserCompleteProfile> user = [];
  String field = 'dateCreation';
  bool descending = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserCompleteProfile>>(
        stream: FirebaseFirestore.instance
            .collection('clients')
            .orderBy(field, descending: descending)
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((doc) => UserCompleteProfile.fromJson(doc.data()))
                .toList()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            // var user;
            if (_searchUser.isNotEmpty) {
              user = snapshot.data!.where((element) {
                return element.firstName
                        .toLowerCase()
                        .contains(_searchUser.toLowerCase()) ||
                    element.email!
                        .toLowerCase()
                        .contains(_searchUser.toLowerCase()) ||
                    element.phoneNumber.contains(_searchUser.toLowerCase());
              }).toList();
            } else {
              user = snapshot.data!;
            }

            // var user = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Users',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 300.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 2.0),
                                    child: TextField(
                                      controller: _userController,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            5.0, 5.0, 5.0, 0),
                                        prefixIcon: Icon(Icons.search_outlined),
                                        hintText: 'Search User',
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
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DataTable(
                                headingTextStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                                columns: [
                                  DataColumn(
                                    label: Row(
                                      children: [
                                        Text('First Name'),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          onTap: (() => sort('firstName')),
                                          child: Icon(
                                            Icons.sort,
                                            color: Colors.grey,
                                            size: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataColumn(
                                    label: Row(
                                      children: [
                                        Text('Last Name'),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          onTap: (() => sort('lastName')),
                                          child: Icon(
                                            Icons.sort,
                                            color: Colors.grey,
                                            size: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataColumn(
                                      label: Row(
                                    children: [
                                      Text('Email Address'),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: (() => sort('email')),
                                        child: Icon(
                                          Icons.sort,
                                          color: Colors.grey,
                                          size: 16.0,
                                        ),
                                      ),
                                    ],
                                  )),
                                  DataColumn(label: Text('Phone Number')),
                                  DataColumn(
                                      label: Row(
                                    children: [
                                      Text('Date'),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: (() => sort('dateCreation')),
                                        child: Icon(
                                          Icons.sort,
                                          color: Colors.grey,
                                          size: 16.0,
                                        ),
                                      ),
                                    ],
                                  )),
                                  DataColumn(label: Text('')),
                                ],
                                rows: UserRows()
                                    .getRowsUsersComplete(user, context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }

  sort(newField) {
    setState(() {
      field = newField;
      descending ? descending = false : descending = true;
    });
  }

  // onTap: (() => sort('firstName')),
}
