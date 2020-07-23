import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/habit_buddy_info.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/models/message.dart';

class ProfileSubViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  Widget showHabitBuddyMood(HabitBuddyInfo habitBuddyInfo) {
    double normalizedMood =
        habitBuddyInfo.evaluationData[0] / habitBuddyInfo.evaluationData[1];

    if (normalizedMood < 4) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddyInfo.habitBuddy.username} fühlt sich derzeit etwas ',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'unmotiviert',
              style: TextStyle(
                color: Color(0xFFFF4081),
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
              'Deinem Habit Buddy ${habitBuddyInfo.habitBuddy.username} geht es derzeit ganz ',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'gut',
              style: TextStyle(
                color: Color(0xFFFF4081),
              ),
            ),
            TextSpan(
              text:
                  ', es könnte aber besser laufen. Vielleicht kannst Du ihn etwas motivieren!',
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddyInfo.habitBuddy.username} is sehr ',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'motiviert',
              style: TextStyle(
                color: Color(0xFFFF4081),
              ),
            ),
            TextSpan(
              text: '. Ihr seid ein klasse Team!',
            ),
          ],
        ),
      );
    }
  }

  Widget buddyLevel(HabitBuddyInfo habitBuddyInfo) {
    if (habitBuddyInfo.buddyLevel == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('0', style: TextStyle(color: Colors.white))],
      );
    }
    if (habitBuddyInfo.buddyLevel == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: accentColor),
        ],
      );
    }
    if (habitBuddyInfo.buddyLevel == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: accentColor),
          Icon(Icons.favorite, color: accentColor),
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

  Future sendMessage(
      {@required String text,
      @required String receiverID,
      HabitBuddyInfo habitBuddyInfo}) async {
    setBusy(true);
    var result = await _firestoreService.sendMessage(Message(
      text: text,
      userID: currentUser.id,
      receiverID: receiverID,
      timestamp: DateTime.now(),
    ));
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not sent message',
        description: result,
      );
    }
  }

  void reduceBuddyLevel(Message firstMessage, HabitBuddyInfo habitBuddyInfo) {
    setBusy(true);
    if (firstMessage != null) {
      var thresholdDay =
          DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;

      var lastEntryDate = firstMessage.timestamp.millisecondsSinceEpoch;
      if (thresholdDay > lastEntryDate) {
        print('wahrheit!');
        if (habitBuddyInfo.buddyLevel == 0) {
          print(habitBuddyInfo.buddyLevel);
        } else {
          habitBuddyInfo.buddyLevel -= 1;
          print("reduziert: ${habitBuddyInfo.buddyLevel}");
        }
      }
    }
    setBusy(false);
  }
}
