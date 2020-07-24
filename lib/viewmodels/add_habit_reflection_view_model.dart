import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

class AddHabitReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final HabitList _habitList = locator<HabitList>();

  Future addHabitWithTemplate(
    String habitName,
    String customDescription,
  ) async {
    setBusy(true);
    if (customDescription == '') {
      _dialogService.showDialog(
          title: 'Deine Beschreibung fehlt.',
          description: noMilestoneDescription);
    } else {
      var habit = await _firestoreService.getHabitTemplate(habitName);
      habit.customDescription = customDescription;
      habit.habitIcon = habitIcon(habitName);
      _habitList.checkListForDupes(habit.name)
          ? _dialogService.showDialog(
              title: 'Obacht!',
              description: doubleMilestoneAdd,
              buttonTitle: 'Och manno..')
          : _habitList.addHabit(habit);
      setBusy(false);
      _navigationService.pop();
    }
  }
}
