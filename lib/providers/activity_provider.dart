import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pottygraph2/models/activity.dart';
import 'package:pottygraph2/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ActivityProvider extends ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  bool _pee;
  bool _poo;
  bool _treat;
  bool _meal;

  String get name => _name;
  bool get pee => _pee;
  bool get poo => _poo;
  bool get treat => _treat;
  bool get meal => _meal;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePee(bool value) {
    _pee = value;
    notifyListeners();
  }

  changePoo(bool value) {
    _poo = value;
    notifyListeners();
  }

  changeTreat(bool value) {
    _treat = value;
    notifyListeners();
  }

  changeMeal(bool value) {
    _meal = value;
    notifyListeners();
  }

  saveActivity() {
    var newActivity = Activity(
      name: _name,
      activityId: Uuid().v4(),
      activityTimestamp: Timestamp.now(),
      pee: _pee,
      poo: _poo,
      treat: _treat,
      meal: _meal,
    );

    firestoreService.saveActivity(newActivity);
  }

  deleteActivity(String activityId) {
    firestoreService.deleteActivity(activityId);
  }
}
