class UserProfile {

  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String isVerified;
  final int dateCreation;


  UserProfile({

    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.isVerified,
    required this.dateCreation,
    
    });

    Map<String, dynamic> toJson() =>{

      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'dateCreation': dateCreation,
    };

    static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isVerified: json['isVerified'],
      dateCreation: json['dateCreation'],
    );

}