import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

class HabitDetailViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  String initialRepetitions(index) {
    return habitList.populateRepetitions(index).toString();
  }

  Future getChartItems(String habitName) async {
    setBusy(true);
    var test = await _firestoreService.getChartData(currentUser.id);
    for (ChartData item in test) {
      if (habitName == item.habitName) {
        chartItems.add(item);
        notifyListeners();
      }
    }
    setBusy(false);
  }
}
