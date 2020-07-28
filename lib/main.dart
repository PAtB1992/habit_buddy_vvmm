import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/services/route_observer.dart';
import 'package:habitbuddyvvmm/ui/router.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/views/start_view.dart';
import 'package:habitbuddyvvmm/managers/dialog_manager.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Buddy',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      navigatorObservers: [MyRouteObserver()],
      home: StartView(),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
    );
  }
}
