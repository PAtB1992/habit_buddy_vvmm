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

  Habit({
    @required this.name,
    @required this.customDescription,
    @required this.customName,
    this.habitID,
    this.listIndex,
    this.reminderID,
    this.reminderType,
    this.isDeleted = false,
    this.repetitions,
    this.habitIcon,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'customDescription': customDescription,
      'customName': customName,
      'repetitions': repetitions,
      'isDeleted': isDeleted,
      'reminderID': reminderID,
      'reminderType': reminderType,
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
        habitID = data['habitID'];

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

//  ListView listBuilder() {
//    return ListView.builder(
//      itemBuilder: (context, index) {
//        final habit = habitList[index];
//        return HabitTile(
//          name: habit.name,
//          repetitions: habit.repetitions,
//          description: habit.customDescription,
//          habitIcon: Icon(
//            habit.habitIcon,
//            color: Colors.white,
//          ),
//          onPress: () {
//            _navigationService.navigateTo(
//              HabitDetailViewRoute,
//              arguments: Habit(
//                name: habit.name,
//                repetitions: habit.repetitions,
//                description: habit.description,
//                listIndex: index,
//                customDescription: habit.customDescription,
//                habitIcon: habit.habitIcon,
//              ),
//            );
//          },
//        );
//      },
//      itemCount: habitCount,
//    );
//  }
}
