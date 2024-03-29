import 'package:adminapp/profile_page_user/user_profile_page.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserRows {
  List<DataRow> getRowsUsers(List<UserCompleteProfile> user, context) {
    return user
        .map((UserCompleteProfile user) => DataRow(cells: [
              DataCell(
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    DateFormat('dd/MM/yy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            user.dateCreation))
                        .toString(),
                    style: const TextStyle(fontSize: 10.0),
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            id: user.id,
                            showNewChatMessage: false,
                          )));
                },
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    user.email!,
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )),
              DataCell(FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.firstName,
                  style: const TextStyle(fontSize: 10.0),
                ),
              )),
              DataCell(FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  user.lastName,
                  style: const TextStyle(fontSize: 10.0),
                ),
              )),
              // DataCell(ElevatedButton(
              //   style: const ButtonStyle(visualDensity: VisualDensity.compact),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => UserProfilePage(id: user.id)));
              //   },
              //   child: const Text(
              //     'View Profile',
              //     style: TextStyle(fontSize: 12.0),
              //   ),
              // )),
            ]))
        .toList();
  }

  List<DataRow> getRowsUsersComplete(List<UserCompleteProfile> user, context) {
    return user
        .map((UserCompleteProfile user) => DataRow(cells: [
              DataCell(
                  Text(user.firstName, style: const TextStyle(fontSize: 12.0))),
              DataCell(
                  Text(user.lastName, style: const TextStyle(fontSize: 12.0))),
              DataCell(
                Text(user.email!, style: const TextStyle(fontSize: 12.0)),
              ),
              DataCell(Text(user.phoneNumber,
                  style: const TextStyle(fontSize: 12.0))),
              DataCell(
                Text(
                    DateFormat('dd/MM/yy')
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            user.dateCreation))
                        .toString(),
                    style: const TextStyle(fontSize: 12.0)),
              ),
              DataCell(ElevatedButton(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            id: user.id,
                            showNewChatMessage: false,
                          )));
                },
                child: const Text('View Profile'),
              )),
            ]))
        .toList();
  }
}

// ignore: must_be_immutable
class UserProfileBioDetails extends StatefulWidget {
  final Color color;
  final String textTitle;
  bool updateObject;
  final TextEditingController controller;
  final String userId;
  final String object;
  final String dataUser;
  bool updateObjectError;
  UserProfileBioDetails(
      {Key? key,
      required this.color,
      required this.textTitle,
      required this.updateObject,
      required this.controller,
      required this.userId,
      required this.object,
      required this.dataUser,
      required this.updateObjectError})
      : super(key: key);

  @override
  State<UserProfileBioDetails> createState() => _UserProfileBioDetailsState();
}

class _UserProfileBioDetailsState extends State<UserProfileBioDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.textTitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: widget.updateObject
                      ? TextField(
                          autofocus: true,
                          controller: widget.controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Insert new value',
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      : TextField(
                          // autofocus: true,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            disabledBorder: const OutlineInputBorder(),
                            hintText: widget.dataUser,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(5, 10, 10, 0),
                            hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                GestureDetector(
                  child: Text(
                    widget.updateObject ? 'Save' : 'Update',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14.0,
                    ),
                  ),
                  onTap: () {
                    if (widget.updateObject == true &&
                        widget.controller.text.isEmpty) {
                      setState(() {
                        widget.updateObjectError = true;
                      });
                      return;
                    }
                    setState(() {
                      widget.updateObject
                          ? widget.updateObject = false
                          : widget.updateObject = true;
                    });
                    if (widget.updateObject == false &&
                        widget.controller.text.isNotEmpty) {
                      DatabaseUserProfile(uid: widget.userId).updateProfileUser(
                          widget.userId,
                          widget.object,
                          widget.controller.text.trim());
                    }
                    widget.controller.clear();
                  },
                ),
                const SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  child: Text(
                    widget.updateObject ? 'Cancel' : '',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14.0,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.controller.clear();
                      widget.updateObject
                          ? widget.updateObject = false
                          : widget.updateObject = true;
                      widget.updateObjectError = false;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: widget.updateObjectError,
                    child: const Text(
                      'Please insert new value or Cancel',
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
