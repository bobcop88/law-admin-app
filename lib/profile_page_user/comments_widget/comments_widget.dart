import 'package:adminapp/utils/admin_comments/database_admin_comments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsBox extends StatefulWidget {
  final String user;
  final String admin;
  const CommentsBox({Key? key, required this.user, required this.admin})
      : super(key: key);

  @override
  State<CommentsBox> createState() => _CommentsBoxState();
}

class _CommentsBoxState extends State<CommentsBox> {
  final _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text(
                  'Comments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder<List<AdminComment>>(
                      stream: DatabaseComments(clientId: widget.user)
                          .getAdminComments(widget.user),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final comments = snapshot.data!;
                          if (comments.isEmpty) {
                            return Column(
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('No comments'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return ListView.separated(
                              controller: ScrollController(),
                              itemCount: comments.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment
                                        //         .start,
                                        children: [
                                          Text(
                                            DateFormat('dd/MM/yyyy HH:MM')
                                                .format(
                                              DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      comments[index]
                                                          .dateComment),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                                comments[index].textComment),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      })),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (_commentController.text.trim().isEmpty) return;
                  DatabaseComments(clientId: widget.user).createComment(
                      _commentController.text.trim(), widget.admin);
                  _commentController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: FloatingActionButton.extended(
              //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //       onPressed: () {
              //         if (_commentController.text.trim().isEmpty) return;
              //         DatabaseComments(clientId: widget.user).createComment(
              //             _commentController.text.trim(), widget.admin);
              //         _commentController.clear();
              //       },
              //       label: const Icon(Icons.add),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
