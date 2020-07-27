import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/views/add_habit_reflection_view.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';

class AddHabitViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  navigateToReflectionView(String habitName) async {
    await _navigationService.navigateTo(AddHabitReflectionViewRoute,
        arguments: habitName);
  }

  navigateToReflectionViewAndWaitForPop(
      BuildContext context, String habitName) async {
    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddHabitReflectionView(
                  habitName: habitName,
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
