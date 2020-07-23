import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Habit {
  final String name;
  final String description;
  int repetitions;
  final int listIndex;
  String customDescription;
  IconData habitIcon;

  Habit({
    @required this.name,
    @required this.description,
    this.customDescription,
    this.repetitions,
    this.listIndex,
    this.habitIcon,
  });

  Habit.fromData(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        repetitions = data['repetitions'],
        listIndex = data['listIndex'],
        customDescription = data['customDescription'],
        habitIcon = data['iconIcon'];

  static Habit fromMap(
    Map<String, dynamic> map,
  ) {
    if (map == null) return null;

    return Habit(
      name: map['name'],
      description: map['description'],
      repetitions: map['repetitions'],
      customDescription: map['customDescription'],
      habitIcon: map['habitIcon'],
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
    //TODO Serverfunction schreiben um Buddy zu benachrichtigen (onChange benutzen?)
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
