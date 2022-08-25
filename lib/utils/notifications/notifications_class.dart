class NotificationAdminDetails {
  String userId;
  String userEmail;
  String notificationType;
  bool isNew;
  int notificationDate;

  NotificationAdminDetails({
    required this.userId,
    required this.userEmail,
    required this.notificationType,
    required this.notificationDate,
    required this.isNew,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userEmail': userEmail,
        'notificationType': notificationType,
        'notificationDate': notificationDate,
        'isNew': isNew
      };

  static NotificationAdminDetails fromJson(Map<String, dynamic> json) =>
      NotificationAdminDetails(
        userId: json['userId'],
        userEmail: json['userEmail'],
        notificationType: json['notificationType'],
        notificationDate: json['notificationDate'],
        isNew: json['isNew'],
      );
}

class NotificationsUserToAdmin {
  final String userId;
  final String nameUser;
  final String emailUser;
  final String notificationType;
  final String notificationDetails;
  final int dateNotification;
  final bool isNew;

  NotificationsUserToAdmin(
      {required this.userId,
      required this.nameUser,
      required this.emailUser,
      required this.notificationType,
      required this.notificationDetails,
      required this.dateNotification,
      required this.isNew});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nameUser': nameUser,
        'emailUser': emailUser,
        'notificationType': notificationType,
        'notificationDetails': notificationDetails,
        'dateNotification': dateNotification,
        'isNew': isNew,
      };
  static NotificationsUserToAdmin fromJson(Map<String, dynamic> json) =>
      NotificationsUserToAdmin(
        userId: json['userId'],
        nameUser: json['nameUser'],
        emailUser: json['emailUser'],
        notificationType: json['notificationType'],
        notificationDetails: json['notificationDetails'],
        dateNotification: json['dateNotification'],
        isNew: json['isNew'],
      );
}
