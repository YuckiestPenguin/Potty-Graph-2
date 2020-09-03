import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String name;
  final String activityId;
  final Timestamp activityTimestamp;

  Activity({this.name, this.activityId, this.activityTimestamp});

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'name': name,
      'activityTimestamp': activityTimestamp
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityId = firestore['activityId'],
        activityTimestamp = firestore['activityTimestamp'],
        name = firestore['name'];
}
