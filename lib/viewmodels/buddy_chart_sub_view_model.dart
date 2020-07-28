import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:flutter/material.dart';
import 'base_model.dart';

class BuddyChartSubViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;
  List<Color> gradientColors = [
    const Color(0xFFC5CAE9),
    const Color(0xFFC5CAE9),
  ];

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  getBuddyChartItems(HabitBuddy habitBuddy) async {
    setBusy(true);
    var test = await _firestoreService.getChartData(habitBuddy.myHabitBuddy.id);
    for (ChartData item in test) {
      _chartItems.add(item);
      notifyListeners();
    }
    setBusy(false);
  }
}
