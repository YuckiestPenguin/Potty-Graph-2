import 'package:flutter/material.dart';
import 'package:pottygraph2/models/activity.dart';
import 'package:pottygraph2/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ActivityProvider extends ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;

  String get name => _name;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  saveActivity() {
    var newActivity = Activity(name: _name, activityId: Uuid().v4());

    firestoreService.saveActivity(newActivity);
  }

  deleteActivity(String activityId) {
    firestoreService.deleteActivity(activityId);
  }
}
