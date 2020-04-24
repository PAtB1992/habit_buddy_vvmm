import 'package:flutter/widgets.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/models/user.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  bool _busy = false;
  bool get busy => _busy;
  User get currentUser => _authenticationService.currentUser;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
