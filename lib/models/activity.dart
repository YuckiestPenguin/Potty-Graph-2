import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String name;
  final String activityId;
  final Timestamp activityTimestamp;
  final bool pee;
  final bool poo;
  final bool meal;
  final bool treat;

  Activity(
      {this.name,
      this.activityId,
      this.activityTimestamp,
      this.pee,
      this.poo,
      this.meal,
      this.treat});

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'name': name,
      'activityTimestamp': activityTimestamp,
      'pee': pee,
      'poo': poo,
      'treat': treat,
      'meal': meal
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityId = firestore['activityId'],
        activityTimestamp = firestore['activityTimestamp'],
        name = firestore['name'],
        pee = firestore['pee'],
        poo = firestore['poo'],
        treat = firestore['treat'],
        meal = firestore['meal'];
}
