import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/models/stats.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';

class BuddyViewModel extends BaseModel {
  final pageViewController = PageController(
    initialPage: 0,
  );
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Message> _messages = [];
  List<Message> get messages => _messages;
  Message firstMessage;

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;
  List<Color> gradientColors = [
    const Color(0xFFC5CAE9),
    const Color(0xFFC5CAE9),
  ];

  void listenToMessages() {
    setBusy(true);
    _firestoreService
        .listenToMessagesRealTime(currentUser)
        .listen((messagesData) {
      List<Message> updatedMessages = messagesData;
      if (updatedMessages != null && updatedMessages.length > 0) {
        _messages = updatedMessages;
        firstMessage = _messages.last;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  bool isMe({int index}) {
    return currentUser.id == messages[index].userID;
  }

  Widget showHabitBuddyMood() {
    double normalizedMood;
    if (habitBuddy.myHabitBuddy.motivationData.length == 0) {
      normalizedMood = 99;
    } else {
      normalizedMood = habitBuddy.myHabitBuddy.motivationData[0] /
          habitBuddy.myHabitBuddy.motivationData[1];
    }

    if (normalizedMood <= 1) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} fühlt sich derzeit insgesamt ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'sehr unmotiviert',
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ', Du solltest versuchen ihn zu motivieren!',
            ),
          ],
        ),
      );
    }
    if (normalizedMood <= 2) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} fühlt sich derzeit insgesamt ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'etwas unmotiviert',
              style: TextStyle(
                  fontSize: 16,
                  color: accentColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  ', es könnte aber bestimmt besser laufen. Vielleicht kannst Du ihn motivieren!',
            ),
          ],
        ),
      );
    }
    if (normalizedMood <= 3) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} ist insgesamt ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'relativ motiviert',
              style: TextStyle(
                  fontSize: 16,
                  color: accentColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '. Vielleicht könnt Ihr Euch mehr unterstützen.',
            ),
          ],
        ),
      );
    }
    if (normalizedMood <= 4) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} ist insgesamt ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'sehr motiviert',
              style: TextStyle(
                  fontSize: 16,
                  color: accentColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '. Ihr seid ein klasse Team!',
            ),
          ],
        ),
      );
    }
    if (normalizedMood > 4) {
      return RichText(
        text: TextSpan(
          text:
              'Dein Habit Buddy ${habitBuddy.myHabitBuddy.username} ist insgesamt ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'super motiviert',
              style: TextStyle(
                  fontSize: 16,
                  color: accentColor,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '. Ihr seid ein starkes Team!',
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
        habitBuddy.myHabitBuddy.lastSet == null) {
      habitBuddy.myHabitBuddy.timestampIncreased = DateTime.now();
      habitBuddy.myHabitBuddy.lastSet = DateTime.now();
      habitBuddy.myHabitBuddy.buddyLevel += 1;

      await _firestoreService.updateBuddyTimestamp(
          habitBuddy.myHabitBuddy, currentUser.id);
      notifyListeners();
    }
    if (habitBuddy.myHabitBuddy.buddyLevel < 3 &&
        habitBuddy.myHabitBuddy.timestampIncreased != null) {
      var lastSet = habitBuddy.myHabitBuddy.lastSet;
      if (lastSet is! DateTime) {
        lastSet = lastSet.toDate();
      }
      var thresholdDay = DateTime.now().subtract(Duration(days: 1));
      print('here1?');
      if (lastSet.isBefore(thresholdDay)) {
        habitBuddy.myHabitBuddy.buddyLevel += 1;
        habitBuddy.myHabitBuddy.timestampIncreased = DateTime.now();
        habitBuddy.myHabitBuddy.lastSet = DateTime.now();
        await _firestoreService.updateBuddyTimestamp(
            habitBuddy.myHabitBuddy, currentUser.id);
      }
    } else {
      print('here?');
      habitBuddy.myHabitBuddy.timestampIncreased = DateTime.now();
      await _firestoreService.updateBuddyTimestamp(
          habitBuddy.myHabitBuddy, currentUser.id);
      notifyListeners();
    }
    setBusy(false);
  }

  onPageChanged(int page) {
    if (page == 1) {
      _firestoreService.addStats(Statistics(
          userID: BaseModel().currentUser.id,
          pageViewName: 'BuddyChartView',
          timestamp: DateTime.now()));
    }
  }
}
