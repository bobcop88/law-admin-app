import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopCardsDashboard extends StatefulWidget {
  final List<UserCompleteProfile> users;
  const TopCardsDashboard({Key? key, required this.users}) : super(key: key);

  @override
  State<TopCardsDashboard> createState() => _TopCardsDashboardState();
}

class _TopCardsDashboardState extends State<TopCardsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 169, 22, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.group_rounded,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 30.0, 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.users.length.toString(),
                          style: const TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Registered Users',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 169, 22, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.group_rounded,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 30.0, 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          userRegisteredThisMonth(widget.users).toString(),
                          style: const TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'User Registered in this month',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 140, 39, 32),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.assignment,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 30.0, 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: Dashboard().readAllServices(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text('Not available');
                              } else {
                                return Text(
                                  snapshot.data!.size.toString(),
                                  style: const TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            }),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Services Requested',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  userRegisteredThisMonth(List<UserCompleteProfile> list) {
    List users = [];
    int firstDayMonth =
        DateTime.utc(DateTime.now().year, DateTime.now().month, 1)
            .microsecondsSinceEpoch;
    int todayDate = DateTime.now().microsecondsSinceEpoch;

    for (var e in list) {
      if (e.dateCreation > firstDayMonth) {
        users.add(e);
      }
    }
    return users.length;
  }
}
