import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class HabitDetailViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();

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

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  String initialRepetitions(index) {
    return habitList.populateRepetitions(index).toString();
  }
}
