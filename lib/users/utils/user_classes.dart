import 'package:adminapp/users/new_users_pages/user_profile_new.dart';
import 'package:adminapp/users/user_profile_page.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserRows {
  List<DataRow> getRowsUsers(List<UserCompleteProfile> user, context) {
    return user
        .map((UserCompleteProfile user) => DataRow(cells: [
              DataCell(
                Text(DateFormat('dd/MM/yy')
                    .format(
                        DateTime.fromMicrosecondsSinceEpoch(user.dateCreation))
                    .toString()),
              ),
              DataCell(Text(user.email!)),
              DataCell(Text(user.firstName)),
              DataCell(Text(user.lastName)),
              DataCell(ElevatedButton(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(id: user.id)));
                },
                child: const Text('View Profile'),
              )),
            ]))
        .toList();
  }

  List<DataRow> getRowsUsersComplete(List<UserCompleteProfile> user, context) {
    return user
        .map((UserCompleteProfile user) => DataRow(cells: [
              DataCell(Text(user.firstName)),
              DataCell(Text(user.lastName)),
              DataCell(Text(user.email!)),
              DataCell(Text(user.phoneNumber)),
              DataCell(
                Text(DateFormat('dd/MM/yy')
                    .format(
                        DateTime.fromMicrosecondsSinceEpoch(user.dateCreation))
                    .toString()),
              ),
              DataCell(ElevatedButton(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfileNew(id: user.id)));
                },
                child: const Text('View Profile'),
              )),
            ]))
        .toList();
  }
}
