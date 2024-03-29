import 'package:adminapp/dashboard/utils/admin_profile_class.dart';
import 'package:adminapp/utils/chat_message_class.dart';
import 'package:adminapp/utils/notifications/notifications_class.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:adminapp/utils/users_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseAdmin {
  final String uid;

  DatabaseAdmin({required this.uid});

  //Create Admin user
  final CollectionReference adminUser =
      FirebaseFirestore.instance.collection('adminUsers');

  Future createAdminUser(
      String name, String phoneNumber, String emailAddress) async {
    final docAdmin = adminUser.doc(uid);

    final admin = Admin(
      adminId: uid,
      fullName: name,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      roleUser: 'Admin',
    );

    final json = admin.toJson();

    await docAdmin.set(json);
  }

  // Read Admin Details

  Stream<Admin> readAdminDetails() {
    return FirebaseFirestore.instance
        .collection('adminUsers')
        .doc(uid)
        .snapshots()
        .map((snapshot) => Admin.fromJson(snapshot.data()!));
  }

  updateAdmin(String field, String newValue) {
    return FirebaseFirestore.instance
        .collection('adminUsers')
        .doc(uid)
        .update({field: newValue});
  }
}

//Users Full List

class DatabaseUsers {
  Stream<List<UserCompleteProfile>> readAllUsers(
      String field, bool descending) {
    return FirebaseFirestore.instance
        .collection('clients')
        .orderBy(field, descending: descending)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserCompleteProfile.fromJson(doc.data()))
            .toList());
  }
}

//Get User Profile

class DatabaseUserProfile {
  final String uid;

  DatabaseUserProfile({required this.uid});

  Stream<UserCompleteProfile> readUserProfile() {
    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserCompleteProfile.fromJson(snapshot.data()!));
  }

  Stream readUserFirebaseProfile() {
    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .snapshots();
  }

  Future updateProfileUser(String uid, String doc, newValue) async {
    await FirebaseFirestore.instance.collection('clients').doc(uid).update({
      doc: newValue,
    });
  }
}

//Get all Services User

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  Stream<List<ServiceDetails>> readAllServices() {
    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .collection('myServices')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceDetails.fromJson(doc.data()))
            .toList());
  }
}

class DatabaseServiceList {
  Stream<List<ServiceDetails>> readAllServicesNew() {
    return FirebaseFirestore.instance
        .collectionGroup('myServices')
        // .orderBy('creationDate')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceDetails.fromJson(doc.data()))
            .toList());
  }
}

//Get User Services

class DatabaseServiceDetails {
  final String uid;
  final String serviceName;

  DatabaseServiceDetails({required this.uid, required this.serviceName});

  Stream<ServiceDetails> readUserServices() {
    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .collection('myServices')
        .doc(serviceName)
        .snapshots()
        .map((snapshot) => ServiceDetails.fromJson(snapshot.data()!));
  }

  Future updateServiceDetails(
      String uid, String serviceName, String doc, String newValue) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .collection('myServices')
        .doc(serviceName)
        .update({
      doc: newValue,
    });
  }

  Future updateServiceRejected(String uid, String serviceName, String doc,
      String newValue, String rejectedReason, bool rejectedNeedDocument) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .collection('myServices')
        .doc(serviceName)
        .update({
      doc: newValue,
      'rejectedReason': rejectedReason,
      'rejectedNeedDocument': rejectedNeedDocument,
    });
  }
}

class Dashboard {
  Stream<List<UserCompleteProfile>> readAllUsers() {
    return FirebaseFirestore.instance
        .collection('clients')
        .orderBy('dateCreation', descending: true)
        // .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserCompleteProfile.fromJson(doc.data()))
            .toList());
  }

  Stream<QuerySnapshot> readAllServices() {
    return FirebaseFirestore.instance.collectionGroup('myServices').snapshots();
  }

  Stream<List<ServiceDetails>> readAllServicesNew() {
    return FirebaseFirestore.instance
        .collectionGroup('myServices')
        // .where('currentState', isEqualTo: 'Started')
        // .where('creationDate', isNull: false)
        // .orderBy('creationDate', descending: true)
        // .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceDetails.fromJson(doc.data()))
            .toList());
  }

  Stream<QuerySnapshot> readAllServicesStarted() {
    return FirebaseFirestore.instance
        .collectionGroup('myServices')
        .where('currentState', isEqualTo: 'Started')
        .snapshots();

    // ListView(
    //   children: snapshot.data!.docs
    //       .map((DocumentSnapshot document) {
    //         Map<String, dynamic> data =
    //             document.data()! as Map<String, dynamic>;
    //         return ListTile(
    //           title: Text(data['serviceName']),
    //           subtitle: Text(data['emailUser']),
    //         );
    //       })
    //       .toList()
    //       .cast(),
    // ),
  }

  Stream<QuerySnapshot> readUsersListDate() {
    return FirebaseFirestore.instance
        .collection('clients')
        .orderBy('dateCreation', descending: true)
        .limit(5)
        .snapshots();
  }

  // Stream<List<UserCompleteProfile>> readAllUsers() {
  //   return FirebaseFirestore.instance
  //       .collection('clients')
  //       // .orderBy('creationDate', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => UserCompleteProfile.fromJson(doc.data()))
  //           .toList());
  // }
}

class DatabaseChat {
  final user = FirebaseAuth.instance.currentUser!.uid;
  Future createChat(String userId, String adminId) async {
    final DocumentReference chatId =
        FirebaseFirestore.instance.collection('chats').doc(userId);

    final json = {
      'senderLastMessage': adminId,
      'timeLastMessage': DateTime.now().microsecondsSinceEpoch,
      'textLastMessage': 'text',
      'admin': adminId,
      'user': userId,
    };

    await chatId.set(json);
  }

  //Create Chat - Send Messages Client

  Future startChat(String userId, String adminId, String messageText) async {
    final CollectionReference chat = FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .collection('messages');

    final chatUser = chat.doc(DateTime.now().millisecondsSinceEpoch.toString());

    final myChat = ChatMessage(
      timeMessage: DateTime.now().microsecondsSinceEpoch,
      sender: adminId,
      messageText: messageText,
    );

    final json = myChat.toJson();
    await chatUser.set(json);

    final DocumentReference lastMessage =
        FirebaseFirestore.instance.collection('chats').doc(userId);

    await lastMessage.set({
      'admin': adminId,
      'user': userId,
      'senderLastMessage': adminId,
      'textLastMessage': messageText,
      'timeLastMessage': DateTime.now().microsecondsSinceEpoch,
      'isRead': false,
    });
  }

  Future<bool> chatExists(userId) async {
    bool exists;
    exists = await FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .get()
        .then((value) => value.exists);
    return exists;
  }

  Future updateLastMessage(userId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .update({'isRead': true});
  }

  Stream<List<ChatMessage>> readChatMessages(id) {
    return FirebaseFirestore.instance
        .collection('chats/$id/messages')
        .orderBy('timeMessage', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromJson(doc.data()))
            .toList());
  }

  Stream<QuerySnapshot> readChats() {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('senderLastMessage',
            isNotEqualTo: 'rVu8FOvKC3aoBcOiq4FKinZY42p1')
        .snapshots();
  }

  Stream<List<LastChatMessage>> readAllChats() {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LastChatMessage.fromJson(doc.data()))
            .toList());
  }

  Stream<LastChatMessage> readLastMessage(id) {
    return FirebaseFirestore.instance
        .collection('chats/')
        .doc(id)
        .snapshots()
        .map((snapshot) => LastChatMessage.fromJson(snapshot.data()!));
  }

  Stream<UserCompleteProfile> fetchName(id) {
    return FirebaseFirestore.instance
        .collection('clients')
        .doc(id)
        .snapshots()
        .map((snapshot) => UserCompleteProfile.fromJson(snapshot.data()!));
  }
}

class Notifications {
  Future newNotificationUser(
      String userId, String userEmail, String notificationType) async {
    final CollectionReference notificationFolder = FirebaseFirestore.instance
        .collection('clients')
        .doc(userId)
        .collection('notificationsFromAdmin');

    final notificationId = notificationFolder
        .doc(DateTime.now().microsecondsSinceEpoch.toString());

    final notification = NotificationAdminDetails(
      userId: userId,
      userEmail: userEmail,
      notificationType: notificationType,
      notificationDate: DateTime.now().microsecondsSinceEpoch,
      isNew: true,
    );

    final json = notification.toJson();
    await notificationId.set(json);

    notificationFolder.doc('first').delete();
  }
}
