import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class MilestoneReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  Future completeMilestone(index) async {
    setBusy(true);
    var dialogResult = await _dialogService.showConfirmationDialog(
        title: 'Klasse!',
        description:
            'Bitte bestätige, dass du den Milestone erfüllt hast. Wenn man so motiviert ist wie du, kann es schon vorkommen, dass man ausversehen auf den großen leuchtenden Button drückt.',
        cancelTitle: 'Doch nicht..',
        confirmationTitle: 'Ja, ich bin fertig!');
    if (dialogResult.confirmed) {
      habitList.incrementRepetitions(index);
    } else {
      print('User has cancelled the dialog');
    }
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
            userId: currentUser.id));
  }
}
