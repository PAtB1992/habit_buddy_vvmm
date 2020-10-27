import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Habit {
  final String name;
  final String customDescription;
  final String customName;
  final int listIndex;
  final String habitID;
  final int reminderID;
  String reminderType;
  bool isDeleted;
  IconData habitIcon;
  int repetitions;
  var wasDone;
  var automaticity;
  var motivation;

  Habit(
      {@required this.name,
      @required this.customDescription,
      @required this.customName,
      this.habitID,
      this.listIndex,
      this.reminderID,
      this.reminderType,
      this.isDeleted = false,
      this.repetitions,
      this.habitIcon,
      this.wasDone,
      this.automaticity,
      this.motivation});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'customDescription': customDescription,
      'customName': customName,
      'repetitions': repetitions,
      'isDeleted': isDeleted,
      'reminderID': reminderID,
      'reminderType': reminderType,
      'wasDone': wasDone,
      'automaticity': automaticity,
      'motivation': motivation,
//      'habitIcon': habitIcon,
    };
  }

  Habit.fromData(Map<String, dynamic> data)
      : name = data['name'],
        customDescription = data['customDescription'],
        customName = data['customName'],
        listIndex = data['listIndex'],
        repetitions = data['repetitions'],
        habitIcon = data['iconIcon'],
        reminderID = data['reminderID'],
        reminderType = data['reminderType'],
        habitID = data['habitID'],
        wasDone = data['wasDone'],
        automaticity = data['automaticity'],
        motivation = data['motivation'];

  static Habit fromMap(Map<String, dynamic> map, String documentID) {
    if (map == null) return null;

    return Habit(
      name: map['name'],
      customDescription: map['customDescription'],
      customName: map['customName'],
      repetitions: map['repetitions'],
      habitIcon: map['habitIcon'],
      habitID: documentID,
      reminderID: map['reminderID'],
      reminderType: map['reminderType'],
      wasDone: map['wasDone'],
      automaticity: map['automaticity'],
      motivation: map['motivation'],
    );
  }
}

class HabitList {
  List<Habit> _habitList = [];

  UnmodifiableListView<Habit> get habitList {
    return UnmodifiableListView(_habitList);
  }

  bool checkListForDupes(String habitName) {
    bool result;
    int counter = 0;
    _habitList.forEach((habit) {
      if (habit.name == habitName) {
        counter += 1;
      }
    });
    if (counter > 0) {
      result = true;
    } else
      result = false;
    return result;
  }

  int get habitCount {
    return _habitList.length;
  }

  void addHabit(Habit habit) {
    _habitList.add(habit);
  }

  void deleteHabit(Habit habit) {
    _habitList.removeWhere((item) => item.name == habit.name);
  }

  void incrementRepetitions(int index) {
    _habitList[index].repetitions += 1;
  }

  int populateRepetitions(int index) {
    return _habitList[index].repetitions;
  }

  void updateListHabit(
      int index, var automaticity, int motivation, int repetitions) {
    _habitList[index].wasDone = DateTime.now();
    _habitList[index].automaticity = automaticity;
    _habitList[index].motivation = motivation;
    _habitList[index].repetitions = repetitions;
  }

  void setReminderType(int index, String reminderType) {
    _habitList[index].reminderType = reminderType;
  }
}
