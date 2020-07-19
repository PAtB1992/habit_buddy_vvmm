import 'package:flutter/cupertino.dart';

class HabitBuddy {
  final String username;
  final String id;
  HabitBuddy myHabitBuddy;

  HabitBuddy({@required this.username, @required this.id});

  HabitBuddy.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'];

  saveHabitBuddy(HabitBuddy habitBuddy) {
    myHabitBuddy = habitBuddy;
  }
}
