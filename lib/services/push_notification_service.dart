import 'dart:io';

import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firestore_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialise() async {
    if (Platform.isIOS) {
      // request permissions if on IOS
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      // Called when app is in foreground
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showNotification(message);
      },
      // Called when app has been closed and opened by push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _checkPayloadAndNavigate(message);
      },
      // Called when app is in background
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _checkPayloadAndNavigate(message);
      },
    );

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Fuck you',
        'ich mach jetzt local notifications', platformChannelSpecifics,
        payload: 'item x');
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return print('Notification payload: $payload');
  }

  saveDeviceToken({String uid}) async {
    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      print(uid);
      var tokens = _firestoreService.usersCollectionReference
          .document(uid)
          .collection('token')
          .document('notificationToken');

      await tokens.setData({
        'token': fcmToken,
        'platform': Platform.operatingSystem,
      });
    }
  }

  void _checkPayloadAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      if (view == 'buddy_view') {
        _navigationService.navigateTo(BuddyViewRoute);
      }
    }
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'Habit Buddy Notifications',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
    );
  }
}
