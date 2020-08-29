import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

class MilestoneReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  bool completedMilestone = false;
  String questionOne;
  String questionTwo;

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

  Future saveMilestoneToStore(Habit habit, int value, int value2) async {
    setBusy(true);
    await _firestoreService.saveMilestone(
      currentUser,
      Milestone(
          timestamp: DateTime.now(),
          habitName: habit.name,
          repetitions: habitList.populateRepetitions(habit.listIndex),
          evaluation: value,
          evaluation2: value2,
          userId: currentUser.id,
          habitId: habit.habitID,
          customName: habit.customName,
          srhiQuestion: 'test',
          srhiQuestion2: 'test2'),
    );
    completedMilestone = true;
    setBusy(false);
  }

  getRandomSrhiItem() {
    setBusy(true);
    List srhiItemList = [
      srhiItem1,
      srhiItem2,
      srhiItem3,
      srhiItem4,
      srhiItem5,
      srhiItem6,
      srhiItem7,
      srhiItem8
    ];
    srhiItemList.shuffle();
    questionOne = srhiItemList.first;
    questionTwo = srhiItemList.last;
    print(questionOne);
    print(questionTwo);
  }
}
