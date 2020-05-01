import 'package:flutter/cupertino.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';

class RegistrationViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  Future register({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmail(
      email: email,
      password: password,
    );
    setBusy(false);
    //Generates token for device
    await _pushNotificationService.saveDeviceToken(uid: currentUser.id);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Registration Failure',
          description: 'General registration failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Registration Failure',
        description: result,
      );
    }
  }
}
