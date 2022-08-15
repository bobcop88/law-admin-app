import 'package:cloud_firestore/cloud_firestore.dart';

class AdminComment {
  final int dateComment;
  final String textComment;
  final String adminCommentOwner;
  AdminComment(
      {required this.dateComment,
      required this.textComment,
      required this.adminCommentOwner});

  Map<String, dynamic> toJson() => {
        'dateComment': dateComment,
        'textComment': textComment,
        'adminCommentOwner': adminCommentOwner
      };

  static AdminComment fromJson(Map<String, dynamic> json) => AdminComment(
      dateComment: json['dateComment'],
      textComment: json['textComment'],
      adminCommentOwner: json['adminCommentOwner']);
}

class DatabaseComments {
  final String clientId;

  DatabaseComments({required this.clientId});

  Future createComment(String textComment, String adminId) async {
    final CollectionReference commentCollection = FirebaseFirestore.instance
        .collection('clients/$clientId/admin_comments');
    final date = DateTime.now().microsecondsSinceEpoch;
    final comment = commentCollection.doc(date.toString());

    final newComment = AdminComment(
      dateComment: date,
      textComment: textComment,
      adminCommentOwner: adminId,
    );

    final json = newComment.toJson();

    await comment.set(json);
  }

  Stream<List<AdminComment>> getAdminComments(id) {
    return FirebaseFirestore.instance
        .collection('clients/$id/admin_comments')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AdminComment.fromJson(doc.data()))
            .toList());
  }
}
