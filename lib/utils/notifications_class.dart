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
