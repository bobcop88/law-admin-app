import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/country_class.dart';

class UserProfilePage extends StatefulWidget {
  final String id;
  const UserProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String serviceName = '';
  String userIdChat = '';
  bool _chatVisible = false;

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

  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _documentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserCompleteProfile>(
        stream: DatabaseUserProfile(uid: widget.id).readUserProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final user = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text('Profile ${user.firstName} ${user.lastName}'),
                ),
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            CircleAvatar(
                              child: Text((user.firstName.split(' ')[0][0] +
                                      user.lastName.split(' ')[0][0])
                                  .toUpperCase()),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Registration date:',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMMM yyyy').format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          user.dateCreation)),
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Personal Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Email Address: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: TextField(
                                        // autofocus: true,
                                        readOnly: true,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          disabledBorder:
                                              const OutlineInputBorder(),
                                          hintText: user.email,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10, 10, 0),
                                          hintStyle: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            UserProfileBioDetails(
                                color: Colors.grey[100]!,
                                textTitle: 'First Name: ',
                                updateObject: updateFirstName,
                                controller: _firstNameController,
                                userId: user.id,
                                object: 'firstName',
                                dataUser: user.firstName,
                                updateObjectError: updateFirstNameError),
                            UserProfileBioDetails(
                                color: Colors.white,
                                textTitle: 'Surname: ',
                                updateObject: updateSurname,
                                controller: _surnameController,
                                userId: user.id,
                                object: 'lastName',
                                dataUser: user.lastName,
                                updateObjectError: updateSurnameError),
                            UserProfileBioDetails(
                                color: Colors.grey[100]!,
                                textTitle: 'Phone number: ',
                                updateObject: updatePhoneNumber,
                                controller: _phoneNumberController,
                                userId: user.id,
                                object: 'phoneNumber',
                                dataUser: user.phoneNumber,
                                updateObjectError: updatePhoneNumberError),
                            UserProfileBioDetails(
                                color: Colors.white,
                                textTitle: 'Document number: ',
                                updateObject: updateDocument,
                                controller: _documentController,
                                userId: user.id,
                                object: 'documentNumber',
                                dataUser: user.documentNumber,
                                updateObjectError: updateDocumentError),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Date of Birth: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      // width: 200,
                                      child: TextField(
                                        // autofocus: true,
                                        readOnly: true,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          disabledBorder:
                                              const OutlineInputBorder(),
                                          hintText: DateFormat('dd MMMM yyyy')
                                              .format(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      user.dateOfBirth)),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10, 10, 0),
                                          hintStyle: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      onTap: () {
                                        _selectDOB(user.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Nationality: ',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        // autofocus: true,
                                        readOnly: true,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          disabledBorder:
                                              const OutlineInputBorder(),
                                          hintText: user.nationality,
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10, 10, 0),
                                          hintStyle: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      onTap: () {
                                        _showCountries(user.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Chat with ${user.firstName}'),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Show Chat'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }

  _showCountries(user) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), side: BorderSide.none),
            backgroundColor: Colors.white,
            title: const Text(
              'Select country',
              style: TextStyle(
                  color: Color.fromRGBO(15, 48, 65, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 500.0,
                width: 300.0,
                child: FutureBuilder<List<Country>>(
                    future: CountryList.getCountries(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            thickness: 1,
                            color: Color.fromRGBO(15, 48, 65, 1),
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return SimpleDialogOption(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data![index].flag ?? '',
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        // color: Color.fromRGBO(253, 69, 77, 1),
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                DatabaseUserProfile(uid: user)
                                    .updateProfileUser(user, 'nationality',
                                        snapshot.data![index].name);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          );
        });
  }

  Future _selectDOB(user) async {
    FocusScope.of(context).unfocus();

    final dateOfBirth = await showDatePicker(
        context: context,
        initialDate: DateTime(1980, 01, 01),
        firstDate: DateTime(1900, 01, 01),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary:
                      Color.fromRGBO(15, 48, 65, 1), // header background color
                  onPrimary:
                      Color.fromARGB(255, 247, 247, 247), // header text color
                  onSurface: Colors.black, // body text color
                ),
                scaffoldBackgroundColor: Colors.white,
              ),
              child: child!);
        });

    if (dateOfBirth != null) {
      DatabaseUserProfile(uid: user).updateProfileUser(
          user, 'dateOfBirth', dateOfBirth.microsecondsSinceEpoch);
      // Navigator.pop(context);
    }
  }
}
