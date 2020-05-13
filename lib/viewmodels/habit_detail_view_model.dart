import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class HabitDetailViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();

  int repetitions;
  Future completeMilestone(index) async {
    setBusy(true);
    var dialogResult = await _dialogService.showConfirmationDialog(
        title: 'titel',
        description: 'description',
        cancelTitle: 'cancelTitel',
        confirmationTitle: 'confirmationTitel');
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
