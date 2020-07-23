import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';

class AddHabitViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

//  Future addHabitWithTemplate(String habitName) async {
//    setBusy(true);
//    var habit = await _firestoreService.getHabitTemplate(habitName);
//    _habitList.checkListForDupes(habit.name)
//        ? _dialogService.showDialog(
//            title: 'Obacht!',
//            description:
//                '"Schön, dass du so motiviert bist, aber du kannst keine Habit mehrfach hinzufügen." - Oscar Wilde',
//            buttonTitle: 'Och manno..')
//        : _habitList.addHabit(habit);
//    setBusy(false);
//    _navigationService.pop();
//  }

  navigateToReflectionView(String habitName) {
    _navigationService.navigateTo(AddHabitReflectionViewRoute,
        arguments: habitName);
  }
}
