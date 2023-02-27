import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/notification.model.dart';

class NotificationController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<NotificationModel>> getNotifications() {
    return firebaseFirestore
        .collection('notifications')
        .where('userId', isEqualTo: 'UapxZgT4OdoggJTLjqjX')
        .where('deleted', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs
            .map((e) => NotificationModel.fromMap(e.data()))
            .toList());
  }
}
