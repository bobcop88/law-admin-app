class ServiceDetails {
  final String serviceName;
  final String currentState;
  final String doc1Status;
  final String doc2Status;
  // final String requestFromAdmin;
  // final String answerFromUser;
  final int creationDate;
  final String emailUser;
  final String doc1Url;
  final String doc2Url;

  ServiceDetails({
    // required this.answerFromUser,
    required this.currentState,
    required this.doc1Status,
    required this.doc2Status,
    // required this.requestFromAdmin,
    required this.serviceName,
    required this.creationDate,
    required this.emailUser,
    required this.doc1Url,
    required this.doc2Url,
  });

  static ServiceDetails fromJson(Map<String, dynamic> json) => ServiceDetails(
        // answerFromUser: json['answerFromUser'],
        currentState: json['currentState'],
        doc1Status: json['doc1Status'],
        doc2Status: json['doc2Status'],
        // requestFromAdmin: json['requestFromAdmin'],
        serviceName: json['serviceName'],
        creationDate: json['creationDate'],
        emailUser: json['emailUser'],
        doc1Url: json['doc1Url'],
        doc2Url: json['doc2Url'],
      );
}
