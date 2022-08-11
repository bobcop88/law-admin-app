import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BuildChats {
  Widget buildChats(chat) {
    return Card(
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                child: Text(chat.user[0]),
              )
            ],
          ),
          Column(
            children: [Text(chat.user), Text(chat.textLastMessage)],
          ),
        ],
      ),
    );
  }
}
