import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  final String habitName;
  final int repetitions;
  final timestamp;

  ChartData({
    @required this.habitName,
    @required this.repetitions,
    @required this.timestamp,
  });

  ChartData.fromData(Map<String, dynamic> data)
      : habitName = data['habitName'],
        repetitions = data['repetitions'],
        timestamp = data['timestamp'];

  static ChartData fromMap(
    Map<String, dynamic> map,
    String documentID,
  ) {
    if (map == null) return null;

    return ChartData(
      habitName: map['habitName'],
      repetitions: map['repetitions'],
      timestamp: map['timestamp'],
    );
  }

  List generateList(List chartDataList, String habitName) {
    List tempHabitList = [];
    for (var item in chartDataList) {
      if (habitName == item.habitName) {
        tempHabitList.add(item);
      }
    }
    return tempHabitList;
  }
}
