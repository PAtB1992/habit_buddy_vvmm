import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/models/message.dart';

class ProfileSubViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  Widget showHabitBuddyMood() {
    double normalizedMood;
    if (habitBuddy.myHabitBuddy.motivationData.length == 0) {
      normalizedMood = 99;
    } else {
      normalizedMood = habitBuddy.myHabitBuddy.motivationData[0] /
          habitBuddy.myHabitBuddy.motivationData[1];
    }

    if (normalizedMood < 4) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} fühlt sich wohl derzeit insgesamt etwas ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'unmotiviert',
              style: TextStyle(
                color: accentColor,
              ),
            ),
            TextSpan(
              text: ', vielleicht kannst Du ihm helfen!',
            ),
          ],
        ),
      );
    }
    if (4 < normalizedMood && normalizedMood < 7) {
      return RichText(
        text: TextSpan(
          text:
              'Deinem Habit Buddy ${habitBuddy.myHabitBuddy.username} geht es derzeit insgesamt ganz ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'gut',
              style: TextStyle(
                fontSize: 16,
                color: accentColor,
              ),
            ),
            TextSpan(
              text:
                  ', es könnte aber bestimmt besser laufen. Vielleicht kannst Du ihn etwas motivieren!',
            ),
          ],
        ),
      );
    }
    if (normalizedMood > 6 && normalizedMood < 11) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} ist insgesamt sehr  ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'motiviert',
              style: TextStyle(
                fontSize: 16,
                color: accentColor,
              ),
            ),
            TextSpan(
              text: '. Ihr seid ein klasse Team!',
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} hat noch ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'keine ',
              style: TextStyle(
                fontSize: 16,
                color: accentColor,
              ),
            ),
            TextSpan(
                text:
                    'Meilensteine absolviert. Vielleicht kannst Du ihn motivieren.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
          ],
        ),
      );
    }
  }

  Widget buddyLevel() {
    if (habitBuddy.myHabitBuddy.buddyLevel == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ],
      );
    }
    if (habitBuddy.myHabitBuddy.buddyLevel == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: accentColor),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ],
      );
    }
    if (habitBuddy.myHabitBuddy.buddyLevel == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: accentColor),
          Icon(Icons.favorite, color: accentColor),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: accentColor),
          Icon(Icons.favorite, color: accentColor),
          Icon(Icons.favorite, color: accentColor),
        ],
      );
    }
  }

  Future sendMessage({
    @required String text,
    @required String receiverID,
  }) async {
    setBusy(true);
    var result = await _firestoreService.sendMessage(Message(
      text: text,
      userID: currentUser.id,
      receiverID: receiverID,
      timestamp: DateTime.now(),
    ));

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not sent message',
        description: result,
      );
    }
    if (habitBuddy.myHabitBuddy.buddyLevel < 3 &&
        habitBuddy.myHabitBuddy.timestampIncreased == null) {
      habitBuddy.myHabitBuddy.timestampIncreased = DateTime.now();
      habitBuddy.myHabitBuddy.buddyLevel += 1;

      await _firestoreService.updateBuddyTimestamp(
          habitBuddy.myHabitBuddy, currentUser.id);
      notifyListeners();
    }
    if (habitBuddy.myHabitBuddy.buddyLevel < 3 &&
        habitBuddy.myHabitBuddy.timestampIncreased != null) {
      var increaseDate =
          habitBuddy.myHabitBuddy.timestampIncreased.millisecondsSinceEpoch;
      var thresholdDay =
          DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;

      if (thresholdDay > increaseDate) {
        habitBuddy.myHabitBuddy.buddyLevel += 1;
        habitBuddy.myHabitBuddy.timestampIncreased = DateTime.now();
        await _firestoreService.updateBuddyTimestamp(
            habitBuddy.myHabitBuddy, currentUser.id);
      }
    }
    setBusy(false);
  }

  Future reduceBuddyLevel(Message firstMessage) async {
    print('hallo?');
    setBusy(true);
    if (habitBuddy.myHabitBuddy.buddyLevel > 0 &&
        habitBuddy.myHabitBuddy.timestampReduced == null) {
      print('hallo??');
      var firstMessageTimestamp = firstMessage.timestamp.millisecondsSinceEpoch;
      print(
          'First Message ${DateTime.fromMillisecondsSinceEpoch(firstMessageTimestamp)}');
      var thresholdDay =
          new DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
      print(
          'Threshold Timestamp: ${DateTime.fromMillisecondsSinceEpoch(thresholdDay)}');
      print('1.zweiter if: ${thresholdDay > firstMessageTimestamp}');
      if (thresholdDay > firstMessageTimestamp) {
        habitBuddy.myHabitBuddy.timestampReduced = DateTime.now();
        habitBuddy.myHabitBuddy.buddyLevel -= 1;
        print(habitBuddy.myHabitBuddy.buddyLevel);
        notifyListeners();
        await _firestoreService.updateBuddyTimestamp(
            habitBuddy.myHabitBuddy, currentUser.id);
      }
    }
    if (habitBuddy.myHabitBuddy.buddyLevel > 0 &&
        habitBuddy.myHabitBuddy.timestampReduced != null) {
      var reduceDate =
          habitBuddy.myHabitBuddy.timestampReduced.millisecondsSinceEpoch;
      var thresholdDay =
          DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
      if (thresholdDay > reduceDate) {
        habitBuddy.myHabitBuddy.timestampReduced = DateTime.now();
        habitBuddy.myHabitBuddy.buddyLevel -= 1;
        print(habitBuddy.myHabitBuddy.buddyLevel);
        notifyListeners();
        await _firestoreService.updateBuddyTimestamp(
            habitBuddy.myHabitBuddy, currentUser.id);
      }
    }
    setBusy(false);
  }
}
