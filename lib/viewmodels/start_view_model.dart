import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/services/authentication_service.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/push_notification_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';

class StartViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();

    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      bool hasHabitBuddy = currentUser.hasHabitBuddy;
      if (hasHabitBuddy) {
        HabitBuddy temp = await _firestoreService.addHabitBuddy(currentUser);
        habitBuddy.saveHabitBuddy(temp);
      }
      _navigationService.navigateTo(HomeViewRoute, arguments: hasHabitBuddy);
    }
  }
}
