import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

class AddHabitReflectionViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final HabitList _habitList = locator<HabitList>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  bool addedHabit = false;
  final PageController pageViewController = PageController(
    initialPage: 1,
  );

  static DateTime pickedDailyDate;
  static DateTime pickedWeeklyDate;

  Future addHabit({
    String customName,
    String habitName,
    String customDescription,
    int reminderID,
  }) async {
    setBusy(true);
    if (customName == '' || customDescription == '') {
      _dialogService.showDialog(
          title: 'Deine Habitbeschreibung ist nicht vollständig.',
          description: noMilestoneDescription);
      addedHabit = false;
    } else {
      Habit habit = Habit(
        habitID: customName,
        name: habitName,
        customDescription: customDescription,
        customName: customName,
        repetitions: 0,
        habitIcon: habitIcon(habitName),
        reminderID: reminderID,
        reminderType: getHabitReminderType(pageViewController.page),
        wasDone: DateTime.now().subtract(Duration(days: 10)),
      );

      if (_habitList.checkListForDupes(habit.name)) {
        _dialogService.showDialog(
            title: 'Halt, stop!',
            description: doubleMilestoneAdd,
            buttonTitle: 'Alles klar.');
      } else {
        var result = await _firestoreService.addHabitToDB(habit, currentUser);
        print(result);
        _habitList.addHabit(habit);
        addedHabit = true;
      }

      setBusy(false);
    }
  }

  void pageControllerFunction(int index) {
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void setReminder(int reminderID, String body) async {
    if (pageViewController.page == 0) {
      await _pushNotificationService.showDailyNotification(reminderID, body,
          Time(pickedDailyDate.hour, pickedDailyDate.minute, 0));
      print('daily');
    }
    if (pageViewController.page == 1) {
      await _pushNotificationService.turnOffNotificationById(reminderID);
      print('deleted');
    }
    if (pageViewController.page == 2) {
      print('weekly');
      if (pickedWeeklyDate.weekday == 1) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Monday);
      }
      if (pickedWeeklyDate.weekday == 2) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Tuesday);
      }
      if (pickedWeeklyDate.weekday == 3) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Wednesday);
      }
      if (pickedWeeklyDate.weekday == 4) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Thursday);
      }
      if (pickedWeeklyDate.weekday == 5) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Friday);
      }
      if (pickedWeeklyDate.weekday == 6) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Saturday);
      }
      if (pickedWeeklyDate.weekday == 7) {
        await _pushNotificationService.showWeeklyNotification(
            reminderID,
            body,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Sunday);
      }
    }
  }

  void showNotification() async {
    await _pushNotificationService.showDailyNotification(
        1, 'test', Time(17, 15, 0));
    print('timer gesetzt');
  }

  void fetchNewWeeklyDate(newDate) {
    setBusy(true);
    pickedWeeklyDate = newDate;
    setBusy(false);
  }

  void fetchNewDailyDate(newDate) {
    setBusy(true);
    pickedDailyDate = newDate;
    setBusy(false);
  }

//  switchNumberToDay() {
//    var dayNumber = pickedWeeklyDate.weekday;
//    switch (dayNumber) {
//      case 1:
//        return Day.Monday;
//      case 2:
//        return Day.Tuesday;
//      case 3:
//        return Day.Wednesday;
//      case 4:
//        return Day.Thursday;
//      case 5:
//        return Day.Friday;
//      case 6:
//        return Day.Saturday;
//      case 7:
//        return Day.Sunday;
//    }
//  }

  getHabitReminderID(String habitName) {
    if (habitName == 'gesünder-ernähren') return 1;
    if (habitName == 'besser-organisieren') return 2;
    if (habitName == 'fähigkeiten-lernen') return 3;
    if (habitName == 'sich-mehr-bewegen') return 4;
    if (habitName == 'mehr-wasser-trinken') return 5;
    if (habitName == 'am-charakter-arbeiten') return 6;
  }

  getHabitReminderType(double pageViewNumber) {
    if (pageViewNumber == 0) return 'daily';
    if (pageViewNumber == 1) return 'no reminder';
    if (pageViewNumber == 2) return 'weekly';
  }
}
