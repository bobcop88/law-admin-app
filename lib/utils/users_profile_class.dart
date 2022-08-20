class UserCompleteProfile {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int dateOfBirth;
  final String nationality;
  final String documentNumber;
  final String id;
  final String? email;
  final int dateCreation;
  final String? token;
  final bool userCompleted;

  UserCompleteProfile(
      {required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.nationality,
      required this.documentNumber,
      required this.phoneNumber,
      required this.id,
      required this.email,
      required this.dateCreation,
      required this.token,
      required this.userCompleted});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'nationality': nationality,
        'documentNumber': documentNumber,
        'phoneNumber': phoneNumber,
        'id': id,
        'email': email,
        'dateCreation': dateCreation,
        'userCompleted': userCompleted,
      };

  static UserCompleteProfile fromJson(Map<String, dynamic> json) =>
      UserCompleteProfile(
          firstName: json['firstName'],
          lastName: json['lastName'],
          dateOfBirth: json['dateOfBirth'],
          nationality: json['nationality'],
          documentNumber: json['documentNumber'],
          phoneNumber: json['phoneNumber'],
          id: json['id'],
          email: json['email'],
          dateCreation: json['dateCreation'],
          token: json['token'],
          userCompleted: json['userCompleted']);
}

class UserAllDetails {
  final String id;
  final String email;
  final String phoneNumber;
  final int dateCreation;
  final String firstName;
  final String lastName;
  final int dateOfBirth;
  final String nationality;
  final String documentNumber;

  UserAllDetails({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.dateCreation,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.nationality,
    required this.documentNumber,
  });

  static UserAllDetails fromJson(Map<String, dynamic> json) => UserAllDetails(
        id: json['id'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        dateCreation: json['dateCreation'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        dateOfBirth: json['dateOfBirth'],
        nationality: json['nationality'],
        documentNumber: json['documentNumber'],
      );
}
