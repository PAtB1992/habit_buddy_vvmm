import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_view_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToAddHabitView() async {
    await _navigationService.navigateTo(AddHabitViewRoute);
  }
}
