import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/ui/views/add_habit_view.dart';
import 'package:habitbuddyvvmm/ui/views/home_view.dart';
import 'package:habitbuddyvvmm/ui/views/login_view.dart';
import 'package:habitbuddyvvmm/ui/views/milestone_reflection_view.dart';
import 'package:habitbuddyvvmm/ui/views/picture_credits_view.dart';
import 'package:habitbuddyvvmm/ui/views/start_view.dart';
import 'package:habitbuddyvvmm/ui/views/registration_view.dart';
import 'package:habitbuddyvvmm/ui/views/buddy_view.dart';
import 'package:habitbuddyvvmm/ui/views/habit_detail_view.dart';
import 'package:habitbuddyvvmm/ui/views/add_habit_reflection_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case StartViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartView(),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case RegistrationViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RegistrationView(),
      );
    case HomeViewRoute:
      var hasHabitBuddy = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(
          hasHabitBuddy: hasHabitBuddy,
        ),
      );
    case BuddyViewRoute:
      var habitBuddy = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: BuddyView(
          habitBuddy: habitBuddy,
        ),
      );
    case AddHabitViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddHabitView(),
      );
    case HabitDetailViewRoute:
      var habit = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HabitDetailView(
          habit: habit,
        ),
      );
    case AddHabitReflectionViewRoute:
      var habitName = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddHabitReflectionView(
          habitName: habitName,
        ),
      );
    case MilestoneReflectionViewRoute:
      var habit = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MilestoneReflectionView(
          habit: habit,
        ),
      );
    case PictureCreditsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PictureCreditsView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
