import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

class EditReminderViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  bool addedHabit = false;
  final PageController pageViewController = PageController(
    initialPage: 1,
  );

  static DateTime pickedDailyDate;
  static DateTime pickedWeeklyDate;

  void pageControllerFunction(int index) {
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void setReminder(Habit habit) async {
    print(habit.motivation);
    if (pageViewController.page == 0) {
      _firestoreService.updateHabit(
          Habit(
            name: habit.name,
            customDescription: habit.customDescription,
            customName: habit.customName,
            habitID: habit.habitID,
            isDeleted: habit.isDeleted,
            reminderID: habit.reminderID,
            reminderType: 'daily',
            repetitions: habit.repetitions,
            wasDone: habit.wasDone,
            automaticity: habit.automaticity,
            motivation: habit.motivation,
          ),
          currentUser);
      await _pushNotificationService.showDailyNotification(
          habit.reminderID,
          habit.customName,
          Time(pickedDailyDate.hour, pickedDailyDate.minute, 0));
      habitList.setReminderType(habit.listIndex, 'daily');
      print('daily');
    }
    if (pageViewController.page == 1) {
      _firestoreService.updateHabit(
          Habit(
            name: habit.name,
            customDescription: habit.customDescription,
            customName: habit.customName,
            habitID: habit.habitID,
            isDeleted: habit.isDeleted,
            reminderID: habit.reminderID,
            reminderType: 'no reminder',
            repetitions: habit.repetitions,
            wasDone: habit.wasDone,
            automaticity: habit.automaticity,
            motivation: habit.motivation,
          ),
          currentUser);

      await _pushNotificationService.turnOffNotificationById(habit.reminderID);
      habitList.setReminderType(habit.listIndex, 'no reminder');
      print('deleted');
    }
    if (pageViewController.page == 2) {
      _firestoreService.updateHabit(
          Habit(
            name: habit.name,
            customDescription: habit.customDescription,
            customName: habit.customName,
            habitID: habit.habitID,
            isDeleted: habit.isDeleted,
            reminderID: habit.reminderID,
            reminderType: 'weekly',
            repetitions: habit.repetitions,
            wasDone: habit.wasDone,
            automaticity: habit.automaticity,
            motivation: habit.motivation,
          ),
          currentUser);
      habitList.setReminderType(habit.listIndex, 'weekly');
      print('weekly');
      if (pickedWeeklyDate.weekday == 1) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Monday);
      }
      if (pickedWeeklyDate.weekday == 2) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Tuesday);
      }
      if (pickedWeeklyDate.weekday == 3) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Wednesday);
      }
      if (pickedWeeklyDate.weekday == 4) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Thursday);
      }
      if (pickedWeeklyDate.weekday == 5) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Friday);
      }
      if (pickedWeeklyDate.weekday == 6) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
            Time(pickedWeeklyDate.hour, pickedWeeklyDate.minute, 0),
            Day.Saturday);
      }
      if (pickedWeeklyDate.weekday == 7) {
        await _pushNotificationService.showWeeklyNotification(
            habit.reminderID,
            habit.customName,
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

  switchNumberToDay() {
    var dayNumber = pickedWeeklyDate.weekday;
    switch (dayNumber) {
      case 1:
        return Day.Monday;
      case 2:
        return Day.Tuesday;
      case 3:
        return Day.Wednesday;
      case 4:
        return Day.Thursday;
      case 5:
        return Day.Friday;
      case 6:
        return Day.Saturday;
      case 7:
        return Day.Sunday;
    }
  }

  int getHabitReminderID(String habitName) {
    if (habitName == 'gesünder-ernähren') return 1;
    if (habitName == 'weniger-fleisch-essen') return 2;
    if (habitName == 'fähigkeiten-lernen') return 3;
    if (habitName == 'sich-mehr-bewegen') return 4;
    if (habitName == 'mehr-wasser-trinken') return 5;
    if (habitName == 'konzentration-steigern') return 6;
  }

  void popScreen() {
    _navigationService.pop();
  }
}
