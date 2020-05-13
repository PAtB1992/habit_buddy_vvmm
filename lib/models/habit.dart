import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/components/habit_tile.dart';
import 'package:habitbuddyvvmm/ui/views/habit_detail_view.dart';

import '../locator.dart';

class Habit {
  final String name;
  final String description;
  int repetitions;
  final int listIndex;

  Habit({
    @required this.name,
    @required this.description,
    this.repetitions,
    this.listIndex,
  });

  Habit.fromData(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        repetitions = data['repetitions'],
        listIndex = data['listIndex'];

  static Habit fromMap(
    Map<String, dynamic> map,
  ) {
    if (map == null) return null;

    return Habit(
      name: map['name'],
      description: map['description'],
      repetitions: map['repetitions'],
    );
  }
}

class HabitList {
  final NavigationService _navigationService = locator<NavigationService>();
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

  void incrementRepetitions(int index) {
    _habitList[index].repetitions += 1;
  }

  int populateRepetitions(int index) {
    return _habitList[index].repetitions;
  }

  ListView listBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final habit = habitList[index];
        return HabitTile(
          name: habit.name,
          repetitions: habit.repetitions,
          onPress: () {
            _navigationService.navigateTo(
              HabitDetailViewRoute,
              arguments: Habit(
                name: habit.name,
                repetitions: habit.repetitions,
                description: habit.description,
                listIndex: index,
              ),
            );
          },
        );
      },
      itemCount: habitCount,
    );
  }
}
