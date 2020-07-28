import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/stats.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/views/milestone_reflection_view.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class HabitDetailViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  String initialRepetitions(index) {
    return habitList.populateRepetitions(index).toString();
  }

  Future getChartItems(String habitName) async {
    setBusy(true);
    var test = await _firestoreService.getChartData(currentUser.id);
    for (ChartData item in test) {
      if (habitName == item.habitName) {
        chartItems.add(item);
        notifyListeners();
      }
    }
    setBusy(false);
  }

  navigateToReflectionViewAndWaitForPop(
      BuildContext context, Habit habit) async {
    try {
      _firestoreService.addStats(Statistics(
          userID: currentUser.id,
          pageViewName: 'MilestoneReflectionView',
          timestamp: DateTime.now()));
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MilestoneReflectionView(
                  habit: habit,
                )),
      );
      if (result) {
        _navigationService.pop();
      }
    } catch (e) {
      print('Result = ${e.message}');
    }
  }
}
