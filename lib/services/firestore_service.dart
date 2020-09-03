import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pottygraph2/models/activity.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveActivity(Activity activity) {
    return _db
        .collection('activities')
        .doc(activity.activityId)
        .set(activity.toMap());
  }

  Stream<List<Activity>> getActivities() {
    return _db.collection("activities").orderBy('activityTimestamp', descending: true).snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Activity.fromFirestore(document.data()))
        .toList());
  }

  Future<void> deleteActivity(String activityId) {
    return _db.collection('activities').doc(activityId).delete();
  }
}
