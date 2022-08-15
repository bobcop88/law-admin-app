import 'package:adminapp/profile_page_user/chat_widget/chat_widget.dart';
import 'package:adminapp/profile_page_user/comments_widget/comments_widget.dart';
import 'package:adminapp/profile_page_user/profile_details_widget/profile_details_box.dart';
import 'package:adminapp/users/service_details_page.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String id;
  final bool showNewChatMessage;
  const UserProfilePage(
      {Key? key, required this.id, required this.showNewChatMessage})
      : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final adminUser = FirebaseAuth.instance.currentUser!.uid;

  String serviceName = '';
  String id = '';
  String userIdChat = '';
  String userDeviceToken = '';
  bool showServiceDetails = false;

  // bool showNewChatMessage = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserCompleteProfile>(
        stream: DatabaseUserProfile(uid: widget.id).readUserProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final user = snapshot.data!;
            // StreamBuilder<LastChatMessage>(
            //   stream: DatabaseChat().readLastMessage(user.id),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       setState(() {
            //         showNewChatMessage = false;
            //       });
            //       print('here');
            //       return Text('');
            //     } else {
            //       if (snapshot.data!.isRead == false &&
            //           snapshot.data!.senderLastMessage != user.id) {
            //         print('check');
            //         setState(() {
            //           showNewChatMessage = true;
            //         });
            //       }
            //       print(showNewChatMessage);
            //       return Text('');
            //     }
            //   },
            // );

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(19, 38, 63, 1),
                title: Center(
                  child: Text('Profile ${user.firstName} ${user.lastName}'),
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ProfileDetailsBox(
                                          firstName: user.firstName,
                                          lastName: user.lastName,
                                          nationality: user.nationality,
                                          dateCreation: user.dateCreation,
                                          email: user.email!,
                                          id: user.id,
                                          dateOfBirth: user.dateOfBirth,
                                          phoneNumber: user.phoneNumber,
                                          documentNumber: user.documentNumber)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                      child: CommentsBox(
                                          user: user.id, admin: adminUser)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ChatBox(
                                          user: user.id,
                                          chatVisible: false,
                                          showNewChatMessage:
                                              widget.showNewChatMessage,
                                          token: user.token!,
                                          firstName: user.firstName,
                                          lastName: user.lastName)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Card(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Active Services',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 20.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: StreamBuilder<
                                              List<ServiceDetails>>(
                                            stream:
                                                DatabaseService(uid: user.id)
                                                    .readAllServices(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                              'No Active Services'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                final service = snapshot.data!;
                                                return Column(
                                                  children: [
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              const Divider(),
                                                      itemCount: service.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              userDeviceToken =
                                                                  user.token!;
                                                              showServiceDetails =
                                                                  true;
                                                              id = user.id;
                                                              serviceName =
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .serviceName;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .description,
                                                                  size: 18.0,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          19,
                                                                          38,
                                                                          63,
                                                                          1),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5.0,
                                                                ),
                                                                Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .serviceName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .blueAccent),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            showServiceDetails
                                ? Expanded(
                                    flex: 2,
                                    // width: MediaQuery.of(context).size.width / 2,
                                    child: Card(
                                      child: ServiceSelectedDetails(
                                        id: id,
                                        serviceName: serviceName,
                                        token: userDeviceToken,
                                        firstName: user.firstName,
                                        email: user.email!,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    flex: 2,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Select an Active Service',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
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
                ),
              ),
            );
          }
        });
  }
}
