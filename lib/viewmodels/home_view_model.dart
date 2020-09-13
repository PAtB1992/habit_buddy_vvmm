import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  static bool habitDone;

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
      var result = await _firestoreService.updateHabit(
          Habit(
              habitID: habit.habitID,
              name: habit.name,
              customName: habit.customName,
              customDescription: habit.customDescription,
              repetitions: habit.repetitions,
              automaticity: habit.automaticity,
              wasDone: habit.wasDone,
              reminderType: habit.reminderType,
              reminderID: habit.reminderID,
              motivation: habit.motivation,
              isDeleted: true),
          currentUser);
      print('update Result: $result');
      habitList.deleteHabit(habit);
      _pushNotificationService.turnOffNotificationById(habit.reminderID);
    } else {
      print('User has cancelled the dialog');
    }
    setBusy(false);
  }

  void homeViewInitialization(bool hasHabitBuddy) {
    fetchHabits();
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

  buddyEvaluation(List<Milestone> milestones, String habitName) {
    if (milestones != null) {
      Milestone tempMilestone = milestones.firstWhere(
          (element) => element.habitName == habitName,
          orElse: () => Milestone(
              habitName: 'keine Milestones',
              repetitions: 0,
              evaluation: 11,
              evaluation2: 11,
              timestamp: DateTime.now(),
              userId: 'Bot'));
      int value = tempMilestone.buddyMood;

      switch (value) {
        case 1:
          return Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_very_dissatisfied,
                color: accentColor,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: AutoSizeText(
                  'Dein Buddy ist sehr unmotiviert!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        case 2:
          return Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_dissatisfied,
                color: accentColorGradient,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: AutoSizeText(
                  'Dein Buddy ist unmotiviert',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        case 3:
          return Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_neutral,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: AutoSizeText(
                  'Deinem Buddy geht es ok',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        case 4:
          return Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_satisfied,
                color: test1,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: AutoSizeText(
                  'Dein Buddy ist motiviert',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        case 5:
          return Column(
            children: <Widget>[
              Icon(
                Icons.sentiment_very_satisfied,
                color: test1,
                size: 30,
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: AutoSizeText(
                  'Dein Buddy ist sehr motiviert!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
      }
      return Column(
        children: <Widget>[
          Icon(
            Icons.sentiment_neutral,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: AutoSizeText(
              'Dein Buddy hat diese Rubrik nicht.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              maxLines: 2,
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    }
  }

  userMotivation(int value) {
    //TODO wording anpassen
    switch (value) {
      case 1:
        return Column(
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: accentColor,
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: AutoSizeText(
                'Jetzt nicht aufgeben!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      case 2:
        return Column(
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: accentColorGradient,
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: AutoSizeText(
                'Dein Buddy ist unmotiviert',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      case 3:
        return Column(
          children: <Widget>[
            Icon(
              Icons.sentiment_neutral,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: AutoSizeText(
                'Deinem Buddy geht es ok',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      case 4:
        return Column(
          children: <Widget>[
            Icon(
              Icons.sentiment_satisfied,
              color: test1,
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: AutoSizeText(
                'Dein Buddy ist motiviert',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
      case 5:
        return Column(
          children: <Widget>[
            Icon(
              Icons.sentiment_very_satisfied,
              color: test1,
              size: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: AutoSizeText(
                'Dein Buddy ist sehr motiviert!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 2,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.sentiment_neutral,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          height: 1,
        ),
        Flexible(
          child: AutoSizeText(
            'Irgendwas hier rein',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  void averageBuddyFeeling() {
    int sumFeeling = 0;
    List<Milestone> tempList = [];
    if (milestones == null) {
      habitBuddy.myHabitBuddy.motivationData = [];
    } else {
      Milestone milestoneOne = milestones.firstWhere(
          (element) => element.habitName == 'fähigkeiten-lernen',
          orElse: () => null);
      if (milestoneOne != null) {
        tempList.add(milestoneOne);
      }

      Milestone milestoneTwo = milestones.firstWhere(
          (element) => element.habitName == 'gesünder-ernähren',
          orElse: () => null);
      if (milestoneTwo != null) {
        tempList.add(milestoneTwo);
      }

      Milestone milestoneThree = milestones.firstWhere(
          (element) => element.habitName == 'am-charakter-arbeiten',
          orElse: () => null);
      if (milestoneThree != null) {
        tempList.add(milestoneThree);
      }

      Milestone milestoneFour = milestones.firstWhere(
          (element) => element.habitName == 'mehr-wasser-trinken',
          orElse: () => null);
      if (milestoneFour != null) {
        tempList.add(milestoneFour);
      }

      Milestone milestoneFive = milestones.firstWhere(
          (element) => element.habitName == 'sich-mehr-bewegen',
          orElse: () => null);
      if (milestoneFive != null) {
        tempList.add(milestoneFive);
      }

      Milestone milestoneSix = milestones.firstWhere(
          (element) => element.habitName == 'besser-organisieren',
          orElse: () => null);
      if (milestoneSix != null) {
        tempList.add(milestoneSix);
      }

      int counter = tempList.length;

      for (Milestone item in tempList) {
        int tempSum = item.buddyMood;
        sumFeeling = sumFeeling + tempSum;
      }

      habitBuddy.myHabitBuddy.motivationData = [sumFeeling, counter];
    }
  }

  Future fetchHabits() async {
    setBusy(true);
    var habitResults = await _firestoreService.getHabits(currentUser);
    setBusy(false);
    if (habitResults is List<Habit>) {
      for (Habit habit in habitResults) {
        if (habit.wasDone != null) {
          habit.wasDone = habit.wasDone.toDate();
        }
        habitList.addHabit(habit);
      }
      notifyListeners();
    }
  }

  bool getHabitDone(wasDone) {
    if (wasDone != null) {
      if (wasDone.day == DateTime.now().day) {
        habitDone = true;
      } else {
        habitDone = false;
      }
    } else {
      habitDone = false;
    }

    return habitDone;
  }
}
