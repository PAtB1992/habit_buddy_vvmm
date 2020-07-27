import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class MilestoneReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  Future completeMilestone(Habit habit) async {
    setBusy(true);
    print(habit.habitID);
    var result = await _firestoreService.updateHabit(
        Habit(
            habitID: habit.habitID,
            name: habit.name,
            customName: habit.customName,
            customDescription: habit.customDescription,
            repetitions: habit.repetitions + 1,
            isDeleted: false),
        currentUser);
    print('Update result: $result');
    habitList.incrementRepetitions(habit.listIndex);
    setBusy(false);
  }

  Future saveMilestoneToStore(Habit habit, int value) async {
    await _firestoreService.saveMilestone(
      currentUser,
      Milestone(
          timestamp: DateTime.now(),
          habitName: habit.name,
          repetitions: habitList.populateRepetitions(habit.listIndex),
          evaluation: value,
          userId: currentUser.id,
          habitId: habit.habitID,
          customName: habit.customName),
    );
  }
}
