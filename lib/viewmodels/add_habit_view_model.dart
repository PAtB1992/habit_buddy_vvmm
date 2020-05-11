import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';

class AddHabitViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final HabitList _habitList = locator<HabitList>();

  void addHabitWithTemplate(String habitName) async {
    setBusy(true);
    var habit = await _firestoreService.getHabitTemplate(habitName);
    _habitList.addHabit(habit);
    setBusy(false);

    _navigationService.pop();
  }
}
