class Log {
  String id;
  String typeUser;
  String emailAddress;
  String logType;
  String action;
  int dateLog;

  Log(
      {required this.id,
      required this.typeUser,
      required this.emailAddress,
      required this.logType,
      required this.dateLog,
      required this.action});

  Map<String, dynamic> toJson() => {
        'id': id,
        'typeUser': typeUser,
        'emailAddress': emailAddress,
        'logType': logType,
        'action': action,
        'dateLog': dateLog
      };

  static Log fromJson(Map<String, dynamic> json) => Log(
      id: json['id'],
      typeUser: json['typeUser'],
      emailAddress: json['emailAddress'],
      logType: json['logType'],
      dateLog: json['dateLog'],
      action: json['action']);
}
