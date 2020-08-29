import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitbuddyvvmm/services/route_observer.dart';
import 'package:habitbuddyvvmm/ui/router.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/views/start_view.dart';
import 'package:habitbuddyvvmm/managers/dialog_manager.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('de')],
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
