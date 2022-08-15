import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final _userController = TextEditingController();
  String _searchUser = '';
  var userId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserCompleteProfile>>(
        stream: DatabaseUsers().readAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            var user;
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
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Users',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
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
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            child: TextField(
                              controller: _userController,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
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
                        headingTextStyle:
                            const TextStyle(color: Colors.grey, fontSize: 12.0),
                        columns: const [
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('Email Address')),
                          DataColumn(label: Text('Phone Number')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('')),
                        ],
                        rows: UserRows().getRowsUsersComplete(user, context),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }
}
