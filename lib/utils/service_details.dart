class ServiceDetails {
  final String serviceName;
  final String currentState;
  final String doc1Status;
  final String doc2Status;
  final int creationDate;
  final String emailUser;
  final String doc1Url;
  final String doc2Url;
  final String rejectedReason;
  final bool rejectedNeedDocument;
  final String userId;

  ServiceDetails({
    required this.currentState,
    required this.doc1Status,
    required this.doc2Status,
    required this.serviceName,
    required this.creationDate,
    required this.emailUser,
    required this.doc1Url,
    required this.doc2Url,
    required this.rejectedReason,
    required this.rejectedNeedDocument,
    required this.userId,
  });

  static ServiceDetails fromJson(Map<String, dynamic> json) => ServiceDetails(
      currentState: json['currentState'],
      doc1Status: json['doc1Status'],
      doc2Status: json['doc2Status'],
      serviceName: json['serviceName'],
      creationDate: json['creationDate'],
      emailUser: json['emailUser'],
      doc1Url: json['doc1Url'],
      doc2Url: json['doc2Url'],
      rejectedReason: json['rejectedReason'],
      rejectedNeedDocument: json['rejectedNeedDocument'],
      userId: json['userId']);
}
