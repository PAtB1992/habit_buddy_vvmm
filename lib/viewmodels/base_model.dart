import 'package:flutter/widgets.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/stats.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/models/user.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final Statistics _statistics = locator<Statistics>();
  final HabitList _habitList = locator<HabitList>();
  final HabitBuddy _habitBuddy = locator<HabitBuddy>();

  bool _busy = false;
  bool get busy => _busy;
  User get currentUser => _authenticationService.currentUser;
  HabitList get habitList => _habitList;
  HabitBuddy get habitBuddy => _habitBuddy;
  Statistics get statistics => _statistics;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
