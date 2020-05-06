import 'package:flutter/widgets.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/models/user.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final HabitList _habitList = locator<HabitList>();
  bool _busy = false;
  bool get busy => _busy;
  User get currentUser => _authenticationService.currentUser;
  HabitList get habitList => _habitList;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
