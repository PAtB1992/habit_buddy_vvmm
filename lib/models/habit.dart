import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:habitbuddyvvmm/ui/components/habit_tile.dart';

class Habit {
  final String name;
  final String description;
  final int repetitions;

  Habit({
    @required this.name,
    @required this.description,
    this.repetitions,
  });

  Habit.fromData(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        repetitions = data['repetitions'];

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
  List<Habit> _habitList = [];

  UnmodifiableListView<Habit> get habitList {
    return UnmodifiableListView(_habitList);
  }

  int get habitCount {
    return _habitList.length;
  }

  void addHabit(Habit habit) {
    _habitList.add(habit);
  }

  ListView listBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final habit = habitList[index];
        return HabitTile(
          name: habit.name,
          repetitions: habit.repetitions,
          onPress: null,
        );
      },
      itemCount: habitCount,
    );
  }
}
