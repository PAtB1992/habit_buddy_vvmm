import 'package:flutter/cupertino.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

class RegistrationViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final hasHabitBuddy = false;

  Future register({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmail(
      email: email,
      password: password,
      username: username,
    );
    setBusy(false);
    //Generates token for device
//    await _pushNotificationService.saveDeviceToken(uid: currentUser.id);
    await _firestoreService.createBuddyTemplate(currentUser);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute, arguments: hasHabitBuddy);
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
