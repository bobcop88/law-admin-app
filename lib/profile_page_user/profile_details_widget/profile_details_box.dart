import 'package:adminapp/users/utils/country_class.dart';
import 'package:adminapp/users/utils/user_classes.dart';
import 'package:adminapp/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileDetailsBox extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String nationality;
  final int dateCreation;
  final String email;
  final String id;
  final int dateOfBirth;
  final String phoneNumber;
  final String documentNumber;
  const ProfileDetailsBox(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.nationality,
      required this.dateCreation,
      required this.email,
      required this.id,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.documentNumber})
      : super(key: key);

  @override
  State<ProfileDetailsBox> createState() => _ProfileDetailsBoxState();
}

class _ProfileDetailsBoxState extends State<ProfileDetailsBox> {
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
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Profile Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Text((widget.firstName.split(' ')[0][0] +
                                  widget.lastName.split(' ')[0][0])
                              .toUpperCase()),
                          radius: 30.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.firstName + ' ' + widget.lastName),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.nationality,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12.0),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Registration date:',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    DateFormat('dd MMMM yyyy').format(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            widget.dateCreation)),
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(),
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
                                disabledBorder: const OutlineInputBorder(),
                                hintText: widget.email,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 10, 10, 0),
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
                      userId: widget.id,
                      object: 'firstName',
                      dataUser: widget.firstName,
                      updateObjectError: updateFirstNameError),
                  UserProfileBioDetails(
                      color: Colors.white,
                      textTitle: 'Surname: ',
                      updateObject: updateSurname,
                      controller: _surnameController,
                      userId: widget.id,
                      object: 'lastName',
                      dataUser: widget.lastName,
                      updateObjectError: updateSurnameError),
                  UserProfileBioDetails(
                      color: Colors.grey[100]!,
                      textTitle: 'Phone number: ',
                      updateObject: updatePhoneNumber,
                      controller: _phoneNumberController,
                      userId: widget.id,
                      object: 'phoneNumber',
                      dataUser: widget.phoneNumber,
                      updateObjectError: updatePhoneNumberError),
                  UserProfileBioDetails(
                      color: Colors.white,
                      textTitle: 'Document number: ',
                      updateObject: updateDocument,
                      controller: _documentController,
                      userId: widget.id,
                      object: 'documentNumber',
                      dataUser: widget.documentNumber,
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
                                disabledBorder: const OutlineInputBorder(),
                                hintText: DateFormat('dd MMMM yyyy').format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        widget.dateOfBirth)),
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 10, 10, 0),
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
                              _selectDOB(widget.id);
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
                                disabledBorder: const OutlineInputBorder(),
                                hintText: widget.nationality,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 10, 10, 0),
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
                              _showCountries(widget.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
              SizedBox(
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
