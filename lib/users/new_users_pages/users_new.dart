import 'package:adminapp/users/new_users_pages/user_profile_new.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UsersNewHome extends StatefulWidget {
  const UsersNewHome({Key? key}) : super(key: key);

  @override
  State<UsersNewHome> createState() => _UsersNewHomeState();
}

class _UsersNewHomeState extends State<UsersNewHome> {
  final _userController = TextEditingController();
  String _searchUser = '';
  var userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserCompleteProfile>>(
        stream: DatabaseUsers().readAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List users = [];

            if (_searchUser.isNotEmpty) {
              users = snapshot.data!.where((element) {
                return element.firstName
                        .toLowerCase()
                        .contains(_searchUser.toLowerCase()) ||
                    element.email!
                        .toLowerCase()
                        .contains(_searchUser.toLowerCase());
              }).toList();
            } else {
              users = snapshot.data!;
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
                              const SizedBox(
                                height: 40.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Users List',
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
                                          prefixIcon:
                                              Icon(Icons.search_outlined),
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
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Expanded(
                                                child: Text('Email Address'),
                                              ),
                                              const Expanded(
                                                child: Text('Name'),
                                              ),
                                              const Expanded(
                                                child:
                                                    Text('Date Registration'),
                                              ),
                                              const Expanded(
                                                child: Text('Phone Number'),
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
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                        itemCount: users.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            hoverColor: Colors.grey[200],
                                            onTap: () {
                                              setState(() {
                                                userId = users[index].id;
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserProfileNew(
                                                                id: userId)));
                                              });
                                            },
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            users[index].email,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            users[index]
                                                                .firstName,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            DateFormat(
                                                                    'dd MMMM yyyy')
                                                                .format(DateTime
                                                                    .fromMicrosecondsSinceEpoch(
                                                                        users[index]
                                                                            .dateCreation)),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            users[index]
                                                                .phoneNumber,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
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
        });
  }
}
