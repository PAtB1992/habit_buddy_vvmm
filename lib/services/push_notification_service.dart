import 'dart:io';

import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firestore_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future initialise() async {
    if (Platform.isIOS) {
      // request permissions if on IOS
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      // Called when app is in foreground
      onMessage: (Map<String, dynamic> message) async {},
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
          .document(fcmToken);

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
      // Navigate to the create post view
      if (view == 'buddy_view') {
        _navigationService.navigateTo(BuddyViewRoute);
      }
    }
  }
}
