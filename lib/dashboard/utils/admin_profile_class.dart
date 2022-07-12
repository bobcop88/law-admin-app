class Admin{

  final String adminId;
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String roleUser;

  Admin({
    required this.adminId,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.roleUser,
  });

  Map<String, dynamic> toJson() =>{

      'adminId': adminId,
      'fullName': fullName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'roleUser': roleUser,
    };

  static Admin fromJson(Map<String, dynamic> json) => Admin(
      adminId: json['adminId'],
      fullName: json['fullName'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
      roleUser: json['roleUser'],
    );

}