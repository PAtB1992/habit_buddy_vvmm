import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class HabitDetailViewModel extends BaseModel {
  int repetitions;
  void completeMilestone(index) {
    setBusy(true);
    habitList.incrementRepetitions(index);
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
