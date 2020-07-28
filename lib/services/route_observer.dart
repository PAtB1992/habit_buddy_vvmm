import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/models/stats.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';

final FirestoreService _firestoreService = locator<FirestoreService>();

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;

    _firestoreService.addStats(Statistics(
        userID: BaseModel().currentUser.id,
        pageViewName: screenName,
        timestamp: DateTime.now()));

    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      if (route.settings.name != null &&
          route.settings.name != '/' &&
          route.settings.name != 'LoginView' &&
          route.settings.name != 'RegistrationView') {
        _sendScreenView(route);
      }
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      if (newRoute.settings.name != null &&
          newRoute.settings.name != '/' &&
          newRoute.settings.name != 'LoginView' &&
          newRoute.settings.name != 'RegistrationView') {
        _sendScreenView(newRoute);
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      if (previousRoute.settings.name != null &&
          previousRoute.settings.name != '/' &&
          previousRoute.settings.name != 'LoginView' &&
          previousRoute.settings.name != 'RegistrationView') {
        _sendScreenView(previousRoute);
      }
    }
  }
}
