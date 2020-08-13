import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

class AddHabitReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final HabitList _habitList = locator<HabitList>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  bool addedHabit = false;

  Future addHabit({
    String customName,
    String habitName,
    String customDescription,
  }) async {
    setBusy(true);
    if (customName == '' || customDescription == '') {
      _dialogService.showDialog(
          title: 'Deine Habitbeschreibung ist nicht vollständig.',
          description: noMilestoneDescription);
      addedHabit = false;
    } else {
      Habit habit = Habit(
          habitID: customName,
          name: habitName,
          customDescription: customDescription,
          customName: customName,
          repetitions: 0,
          habitIcon: habitIcon(habitName));

      if (_habitList.checkListForDupes(habit.name)) {
        _dialogService.showDialog(
            title: 'Halt, stop!',
            description: doubleMilestoneAdd,
            buttonTitle: 'Alles klar.');
      } else {
        var result = await _firestoreService.addHabitToDB(habit, currentUser);
        print(result);
        _habitList.addHabit(habit);
        addedHabit = true;
      }

      setBusy(false);
    }
  }

  void showNotification() async {
    await _pushNotificationService.demoNotification();
  }
}
