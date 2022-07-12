import 'dart:developer';

class ServiceDetails {

  final String serviceName;
  final String currentState;
  final String doc1Status;
  final String doc2Status;
  final String requestFromAdmin;
  final String answerFromUser;
  final int creationDate;
  final String emailUser;


  ServiceDetails({
    required this.answerFromUser,
    required this.currentState,
    required this.doc1Status,
    required this.doc2Status,
    required this.requestFromAdmin,
    required this.serviceName,
    required this.creationDate,
    required this.emailUser,
  });

  static ServiceDetails fromJson(Map<String, dynamic> json) => ServiceDetails(
      answerFromUser: json['answerFromUser'],
      currentState: json['currentState'],
      doc1Status: json['doc1Status'],
      doc2Status: json['doc2Status'],
      requestFromAdmin: json['requestFromAdmin'],
      serviceName: json['serviceName'],
      creationDate: json['creationDate'],
      emailUser: json['emailUser']
    );


}