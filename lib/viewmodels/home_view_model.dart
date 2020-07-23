import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Milestone> _milestones;
  List<Milestone> get milestones => _milestones;

  Future navigateToAddHabitView() async {
    await _navigationService.navigateTo(AddHabitViewRoute);
    notifyListeners();
  }

  Future deleteHabit(Habit habit) async {
    setBusy(true);
    var dialogResult = await _dialogService.showConfirmationDialog(
        title: 'Löschen',
        description: 'Möchtest Du diese Habit wirklich löschen?',
        cancelTitle: 'Nein.',
        confirmationTitle: 'Ja.');
    if (dialogResult.confirmed) {
      habitList.deleteHabit(habit);
    } else {
      print('User has cancelled the dialog');
    }
    setBusy(false);
  }

  void listenToHabitBuddy(bool hasHabitBuddy) {
    if (hasHabitBuddy) {
      setBusy(true);

      _firestoreService.listenToBuddyRealTime().listen((milestonesData) {
        List<Milestone> updatedMilestones = milestonesData;
        if (updatedMilestones != null && updatedMilestones.length > 0) {
          _milestones = updatedMilestones;
          notifyListeners();
        }
        setBusy(false);
      });
    }
  }

  String buddyEvaluation(List<Milestone> milestones, String habitName) {
    Milestone tempMilestone = milestones.firstWhere(
        (element) => element.habitName == habitName,
        orElse: () => Milestone(
            habitName: 'keine Milestones',
            repetitions: 0,
            evaluation: 11,
            timestamp: DateTime.now(),
            userId: 'Bot'));
    int value = tempMilestone.evaluation;
    switch (value) {
      case 0:
        return 'Dein Habit Buddy ist kurz vorm Aufgeben!';
      case 1:
        return 'Dein Habit Buddy ist super unmotiviert!';
      case 2:
        return 'Der Wille deines Habit Buddy bröckelt!';
      case 3:
        return 'Dein Habit Buddy will nicht mehr, aber hält durch.';
      case 4:
        return 'Dein Habit Buddy hat nicht so viel Lust, bleibt aber dran.';
      case 5:
        return 'Dein Habit Buddy bleibt dran.';
      case 6:
        return 'Dein Habit Buddy ist stehts diszipliniert.';
      case 7:
        return 'Die Habit bereitet deinem Buddy Freude.';
      case 8:
        return 'Bei deinem Habit Buddy läuft es richtig gut.';
      case 9:
        return 'Deinem Habit Buddy geht es sehr gut.';
      case 10:
        return 'Dein Habit Buddy ist motivierter denn je!';
    }
    return 'Dein Habit Buddy hat diese Habit nicht.';
  }

  List averageBuddyFeeling(List<Milestone> milestones) {
    int sumFeeling = 0;
    List<Milestone> tempList = [];
    Milestone milestoneOne = milestones.firstWhere(
        (element) => element.habitName == 'Fähigkeiten lernen',
        orElse: () => null);
    if (milestoneOne != null) {
      tempList.add(milestoneOne);
    }

    Milestone milestoneTwo = milestones.firstWhere(
        (element) => element.habitName == 'Gesünder ernähren',
        orElse: () => null);
    if (milestoneTwo != null) {
      tempList.add(milestoneTwo);
    }

    Milestone milestoneThree = milestones.firstWhere(
        (element) => element.habitName == 'Konzentration steigern',
        orElse: () => null);
    if (milestoneThree != null) {
      tempList.add(milestoneThree);
    }

    Milestone milestoneFour = milestones.firstWhere(
        (element) => element.habitName == 'Mehr Wasser trinken',
        orElse: () => null);
    if (milestoneFour != null) {
      tempList.add(milestoneFour);
    }

    Milestone milestoneFive = milestones.firstWhere(
        (element) => element.habitName == 'Mehr bewegen',
        orElse: () => null);
    if (milestoneFive != null) {
      tempList.add(milestoneFive);
    }

    Milestone milestoneSix = milestones.firstWhere(
        (element) => element.habitName == 'Weniger Fleisch essen',
        orElse: () => null);
    if (milestoneSix != null) {
      tempList.add(milestoneSix);
    }

    int counter = tempList.length;

    for (Milestone item in tempList) {
      sumFeeling = sumFeeling + item.evaluation;
    }

    return [sumFeeling, counter];
  }
}
