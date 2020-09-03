class Activity {
  final String name;
  final String activityId;

  Activity({this.name, this.activityId});

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'name': name,
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityId = firestore['activityId'],
        name = firestore['name'];
}
