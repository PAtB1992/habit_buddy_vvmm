import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class MilestoneReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  bool completedMilestone = false;

  Future completeMilestone(Habit habit) async {
    setBusy(true);

    print(habitList.habitList[habit.listIndex].repetitions);
    await _firestoreService.updateHabit(
        Habit(
            habitID: habit.habitID,
            name: habit.name,
            customName: habit.customName,
            customDescription: habit.customDescription,
            repetitions: habit.repetitions + 1,
            isDeleted: false,
            reminderID: habit.reminderID),
        currentUser);
    notifyListeners();
    habitList.incrementRepetitions(habit.listIndex);
    setBusy(false);
  }

  Future saveMilestoneToStore(Habit habit, int value) async {
    setBusy(true);
    await _firestoreService.saveMilestone(
      currentUser,
      Milestone(
          timestamp: DateTime.now(),
          habitName: habit.name,
          repetitions: habitList.populateRepetitions(habit.listIndex),
          evaluation: value,
          userId: currentUser.id,
          habitId: habit.habitID,
          customName: habit.customName,
          srhiQuestion: 'test'),
    );
    completedMilestone = true;
    setBusy(false);
  }
}
