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

  bool updateFirstName = false;
  bool updateFirstNameError = false;
  bool updateSurname = false;
  bool updateSurnameError = false;
  bool updatePhoneNumber = false;
  bool updatePhoneNumberError = false;
  bool updateDocument = false;
  bool updateDocumentError = false;
  bool updateNationality = false;
  bool updateNationalityError = false;
  // bool showNewChatMessage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkNewChat(widget.id);
  }

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
                                          documentNumber: user.documentNumber)
                                      // Card(
                                      //   child: Row(
                                      //     children: [
                                      //       Expanded(
                                      //         child: SingleChildScrollView(
                                      //           child: Column(
                                      //             // mainAxisAlignment: MainAxisAlignment.center,
                                      //             children: [
                                      //               const SizedBox(
                                      //                 height: 10.0,
                                      //               ),
                                      //               Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.all(
                                      //                         8.0),
                                      //                 child: Row(
                                      //                   children: [
                                      //                     CircleAvatar(
                                      //                       child: Text((user
                                      //                                       .firstName
                                      //                                       .split(
                                      //                                           ' ')[
                                      //                                   0][0] +
                                      //                               user.lastName
                                      //                                       .split(
                                      //                                           ' ')[
                                      //                                   0][0])
                                      //                           .toUpperCase()),
                                      //                       radius: 30.0,
                                      //                     ),
                                      //                     const SizedBox(
                                      //                       width: 5.0,
                                      //                     ),
                                      //                     Column(
                                      //                       crossAxisAlignment:
                                      //                           CrossAxisAlignment
                                      //                               .start,
                                      //                       children: [
                                      //                         Text(user
                                      //                                 .firstName +
                                      //                             ' ' +
                                      //                             user.lastName),
                                      //                         const SizedBox(
                                      //                           height: 5.0,
                                      //                         ),
                                      //                         Text(
                                      //                           user.nationality,
                                      //                           style: TextStyle(
                                      //                               color: Colors
                                      //                                   .grey,
                                      //                               fontSize:
                                      //                                   12.0),
                                      //                         ),
                                      //                         const SizedBox(
                                      //                           height: 5.0,
                                      //                         ),
                                      //                         Row(
                                      //                           // mainAxisAlignment: MainAxisAlignment.end,
                                      //                           children: [
                                      //                             Text(
                                      //                               'Registration date:',
                                      //                               style: TextStyle(
                                      //                                   color: Colors
                                      //                                       .grey,
                                      //                                   fontSize:
                                      //                                       12.0),
                                      //                             ),
                                      //                             Padding(
                                      //                               padding: const EdgeInsets
                                      //                                       .only(
                                      //                                   right:
                                      //                                       8.0),
                                      //                               child: Text(
                                      //                                 DateFormat(
                                      //                                         'dd MMMM yyyy')
                                      //                                     .format(
                                      //                                         DateTime.fromMicrosecondsSinceEpoch(user.dateCreation)),
                                      //                                 style: TextStyle(
                                      //                                     fontSize:
                                      //                                         12.0),
                                      //                               ),
                                      //                             ),
                                      //                           ],
                                      //                         ),
                                      //                       ],
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //               const SizedBox(
                                      //                 height: 10.0,
                                      //               ),
                                      //               const Divider(),
                                      //               Container(
                                      //                 decoration:
                                      //                     const BoxDecoration(
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 child: Padding(
                                      //                   padding:
                                      //                       const EdgeInsets.all(
                                      //                           8.0),
                                      //                   child: Row(
                                      //                     children: [
                                      //                       const Text(
                                      //                         'Email Address: ',
                                      //                         style: TextStyle(
                                      //                           color:
                                      //                               Colors.grey,
                                      //                         ),
                                      //                       ),
                                      //                       Expanded(
                                      //                         // width: 200,
                                      //                         child: TextField(
                                      //                           // autofocus: true,
                                      //                           readOnly: true,
                                      //                           enabled: false,
                                      //                           decoration:
                                      //                               InputDecoration(
                                      //                             disabledBorder:
                                      //                                 const OutlineInputBorder(),
                                      //                             hintText:
                                      //                                 user.email,
                                      //                             isDense: true,
                                      //                             contentPadding:
                                      //                                 const EdgeInsets
                                      //                                         .fromLTRB(
                                      //                                     5,
                                      //                                     10,
                                      //                                     10,
                                      //                                     0),
                                      //                             hintStyle: const TextStyle(
                                      //                                 fontSize:
                                      //                                     14.0,
                                      //                                 color: Colors
                                      //                                     .black,
                                      //                                 fontWeight:
                                      //                                     FontWeight
                                      //                                         .bold),
                                      //                           ),
                                      //                           style: const TextStyle(
                                      //                               color: Colors
                                      //                                   .black,
                                      //                               fontWeight:
                                      //                                   FontWeight
                                      //                                       .bold),
                                      //                         ),
                                      //                       ),
                                      //                       const SizedBox(
                                      //                         width: 8.0,
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               UserProfileBioDetails(
                                      //                   color: Colors.grey[100]!,
                                      //                   textTitle: 'First Name: ',
                                      //                   updateObject:
                                      //                       updateFirstName,
                                      //                   controller:
                                      //                       _firstNameController,
                                      //                   userId: user.id,
                                      //                   object: 'firstName',
                                      //                   dataUser: user.firstName,
                                      //                   updateObjectError:
                                      //                       updateFirstNameError),
                                      //               UserProfileBioDetails(
                                      //                   color: Colors.white,
                                      //                   textTitle: 'Surname: ',
                                      //                   updateObject:
                                      //                       updateSurname,
                                      //                   controller:
                                      //                       _surnameController,
                                      //                   userId: user.id,
                                      //                   object: 'lastName',
                                      //                   dataUser: user.lastName,
                                      //                   updateObjectError:
                                      //                       updateSurnameError),
                                      //               UserProfileBioDetails(
                                      //                   color: Colors.grey[100]!,
                                      //                   textTitle:
                                      //                       'Phone number: ',
                                      //                   updateObject:
                                      //                       updatePhoneNumber,
                                      //                   controller:
                                      //                       _phoneNumberController,
                                      //                   userId: user.id,
                                      //                   object: 'phoneNumber',
                                      //                   dataUser:
                                      //                       user.phoneNumber,
                                      //                   updateObjectError:
                                      //                       updatePhoneNumberError),
                                      //               UserProfileBioDetails(
                                      //                   color: Colors.white,
                                      //                   textTitle:
                                      //                       'Document number: ',
                                      //                   updateObject:
                                      //                       updateDocument,
                                      //                   controller:
                                      //                       _documentController,
                                      //                   userId: user.id,
                                      //                   object: 'documentNumber',
                                      //                   dataUser:
                                      //                       user.documentNumber,
                                      //                   updateObjectError:
                                      //                       updateDocumentError),
                                      //               Container(
                                      //                 decoration: BoxDecoration(
                                      //                   color: Colors.grey[100],
                                      //                 ),
                                      //                 child: Padding(
                                      //                   padding:
                                      //                       const EdgeInsets.all(
                                      //                           8.0),
                                      //                   child: Row(
                                      //                     children: [
                                      //                       const Text(
                                      //                         'Date of Birth: ',
                                      //                         style: TextStyle(
                                      //                           color:
                                      //                               Colors.grey,
                                      //                         ),
                                      //                       ),
                                      //                       Expanded(
                                      //                         // width: 200,
                                      //                         child: TextField(
                                      //                           // autofocus: true,
                                      //                           readOnly: true,
                                      //                           enabled: false,
                                      //                           decoration:
                                      //                               InputDecoration(
                                      //                             disabledBorder:
                                      //                                 const OutlineInputBorder(),
                                      //                             hintText: DateFormat(
                                      //                                     'dd MMMM yyyy')
                                      //                                 .format(DateTime
                                      //                                     .fromMicrosecondsSinceEpoch(
                                      //                                         user.dateOfBirth)),
                                      //                             isDense: true,
                                      //                             contentPadding:
                                      //                                 const EdgeInsets
                                      //                                         .fromLTRB(
                                      //                                     5,
                                      //                                     10,
                                      //                                     10,
                                      //                                     0),
                                      //                             hintStyle: const TextStyle(
                                      //                                 fontSize:
                                      //                                     14.0,
                                      //                                 color: Colors
                                      //                                     .black,
                                      //                                 fontWeight:
                                      //                                     FontWeight
                                      //                                         .bold),
                                      //                           ),
                                      //                           style: const TextStyle(
                                      //                               color: Colors
                                      //                                   .black,
                                      //                               fontWeight:
                                      //                                   FontWeight
                                      //                                       .bold),
                                      //                         ),
                                      //                       ),
                                      //                       const SizedBox(
                                      //                         width: 8.0,
                                      //                       ),
                                      //                       GestureDetector(
                                      //                         child: const Text(
                                      //                           'Update',
                                      //                           style: TextStyle(
                                      //                             color: Colors
                                      //                                 .blueAccent,
                                      //                             fontSize: 14.0,
                                      //                           ),
                                      //                         ),
                                      //                         onTap: () {
                                      //                           _selectDOB(
                                      //                               user.id);
                                      //                         },
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Container(
                                      //                 decoration:
                                      //                     const BoxDecoration(
                                      //                   color: Colors.white,
                                      //                 ),
                                      //                 child: Padding(
                                      //                   padding:
                                      //                       const EdgeInsets.all(
                                      //                           8.0),
                                      //                   child: Row(
                                      //                     children: [
                                      //                       const Text(
                                      //                         'Nationality: ',
                                      //                         style: TextStyle(
                                      //                           color:
                                      //                               Colors.grey,
                                      //                         ),
                                      //                       ),
                                      //                       Expanded(
                                      //                         child: TextField(
                                      //                           // autofocus: true,
                                      //                           readOnly: true,
                                      //                           enabled: false,
                                      //                           decoration:
                                      //                               InputDecoration(
                                      //                             disabledBorder:
                                      //                                 const OutlineInputBorder(),
                                      //                             hintText: user
                                      //                                 .nationality,
                                      //                             isDense: true,
                                      //                             contentPadding:
                                      //                                 const EdgeInsets
                                      //                                         .fromLTRB(
                                      //                                     5,
                                      //                                     10,
                                      //                                     10,
                                      //                                     0),
                                      //                             hintStyle: const TextStyle(
                                      //                                 fontSize:
                                      //                                     14.0,
                                      //                                 color: Colors
                                      //                                     .black,
                                      //                                 fontWeight:
                                      //                                     FontWeight
                                      //                                         .bold),
                                      //                           ),
                                      //                           style: const TextStyle(
                                      //                               color: Colors
                                      //                                   .black,
                                      //                               fontWeight:
                                      //                                   FontWeight
                                      //                                       .bold),
                                      //                         ),
                                      //                       ),
                                      //                       const SizedBox(
                                      //                         width: 8.0,
                                      //                       ),
                                      //                       GestureDetector(
                                      //                         child: const Text(
                                      //                           'Update',
                                      //                           style: TextStyle(
                                      //                             color: Colors
                                      //                                 .blueAccent,
                                      //                             fontSize: 14.0,
                                      //                           ),
                                      //                         ),
                                      //                         onTap: () {
                                      //                           _showCountries(
                                      //                               user.id);
                                      //                         },
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      ),
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
                                        children: [
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
                                                return Center(
                                                  child: Text(
                                                      'No Active Services'),
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
                                                                Icon(
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
                                                                  style: TextStyle(
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
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    flex: 2,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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

  // _showCountries(user) async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10), side: BorderSide.none),
  //           backgroundColor: Colors.white,
  //           title: const Text(
  //             'Select country',
  //             style: TextStyle(
  //                 color: Color.fromRGBO(15, 48, 65, 1),
  //                 fontSize: 25.0,
  //                 fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.center,
  //           ),
  //           children: [
  //             const SizedBox(
  //               height: 10.0,
  //             ),
  //             Container(
  //               height: 500.0,
  //               width: 300.0,
  //               child: FutureBuilder<List<Country>>(
  //                   future: CountryList.getCountries(),
  //                   builder: (context, snapshot) {
  //                     if (!snapshot.hasData) {
  //                       return const Center(child: CircularProgressIndicator());
  //                     } else {
  //                       return ListView.separated(
  //                         physics: const AlwaysScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         separatorBuilder: (BuildContext context, int index) =>
  //                             const Divider(
  //                           thickness: 1,
  //                           color: Color.fromRGBO(15, 48, 65, 1),
  //                         ),
  //                         itemCount: snapshot.data!.length,
  //                         itemBuilder: (context, index) {
  //                           return SimpleDialogOption(
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text(
  //                                   snapshot.data![index].flag ?? '',
  //                                   style: const TextStyle(
  //                                     fontSize: 17.0,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   width: 5.0,
  //                                 ),
  //                                 Expanded(
  //                                   child: Text(
  //                                     snapshot.data![index].name,
  //                                     style: const TextStyle(
  //                                       fontSize: 17.0,
  //                                       // color: Color.fromRGBO(253, 69, 77, 1),
  //                                       // fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             onPressed: () {
  //                               DatabaseUserProfile(uid: user)
  //                                   .updateProfileUser(user, 'nationality',
  //                                       snapshot.data![index].name);
  //                               Navigator.pop(context);
  //                             },
  //                           );
  //                         },
  //                       );
  //                     }
  //                   }),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // Future _selectDOB(user) async {
  //   FocusScope.of(context).unfocus();

  //   final dateOfBirth = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime(1980, 01, 01),
  //       firstDate: DateTime(1900, 01, 01),
  //       lastDate: DateTime.now(),
  //       builder: (context, child) {
  //         return Theme(
  //             data: Theme.of(context).copyWith(
  //               colorScheme: const ColorScheme.light(
  //                 primary:
  //                     Color.fromRGBO(15, 48, 65, 1), // header background color
  //                 onPrimary:
  //                     Color.fromARGB(255, 247, 247, 247), // header text color
  //                 onSurface: Colors.black, // body text color
  //               ),
  //               scaffoldBackgroundColor: Colors.white,
  //             ),
  //             child: child!);
  //       });

  //   if (dateOfBirth != null) {
  //     DatabaseUserProfile(uid: user).updateProfileUser(
  //         user, 'dateOfBirth', dateOfBirth.microsecondsSinceEpoch);
  //     // Navigator.pop(context);
  //   }
  // }

  // Future _showChatUser(clientId, token) async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           title: Text('Chat'),
  //           children: [
  //             Container(
  //                 width: 500,
  //                 height: 500,
  //                 child: UserChat(
  //                   clientId: clientId,
  //                   userDeviceToken: token,
  //                 )),
  //           ],
  //         );
  //       });
  // }

  // void checkNewChat(id) {
  //   FirebaseFirestore.instance.collection('chats').doc(id).get().then((value) {
  //     if (value.data()!['isRead'] == false &&
  //         value.data()!['senderLastMessage'] == widget.id) {
  //       setState(() {
  //         showNewChatMessage = true;
  //       });
  //     } else {
  //       setState(() {
  //         showNewChatMessage = false;
  //       });
  //     }
  //   });
  // }
}
