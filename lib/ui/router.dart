import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/ui/views/home_view.dart';
import 'package:habitbuddyvvmm/ui/views/login_view.dart';
import 'package:habitbuddyvvmm/ui/views/start_view.dart';
import 'package:habitbuddyvvmm/ui/views/registration_view.dart';
import 'package:habitbuddyvvmm/ui/views/buddy_view.dart';

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
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case BuddyViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: BuddyView(),
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
