import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/user.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';

class HabitDetailViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;

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

  Future saveMilestoneToStore(Habit habit) async {
    await _firestoreService.saveMilestone(
        currentUser,
        Milestone(
            timestamp: DateTime.now(),
            habitName: habit.name,
            repetitions: habitList.populateRepetitions(habit.listIndex)));
  }

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  String initialRepetitions(index) {
    return habitList.populateRepetitions(index).toString();
  }

  Future getChartItems(String habitName) async {
    var test = await _firestoreService.getChartData(currentUser, habitName);
    for (ChartData item in test) {
      if (habitName == item.habitName) {
        chartItems.add(item);
      }
    }
  }
}