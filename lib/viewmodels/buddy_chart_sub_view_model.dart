import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit_buddy_info.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:flutter/material.dart';
import 'base_model.dart';

class BuddyChartSubViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List _chartItems = [];
  List get chartItems => _chartItems;
  int repetitions;
  List<Color> gradientColors = [
    const Color(0xFFC5CAE9),
    const Color(0xFFC5CAE9),
  ];

  void getRepetitions(index) {
    setBusy(true);
    repetitions = habitList.populateRepetitions(index);
    setBusy(false);
  }

  getBuddyChartItems(HabitBuddyInfo habitBuddyInfo) async {
    setBusy(true);
    var test =
        await _firestoreService.getChartData(habitBuddyInfo.habitBuddy.id);
    for (ChartData item in test) {
      _chartItems.add(item);
      notifyListeners();
    }
    setBusy(false);
    print(busy);
  }

//  LineChartData mainData() {
//    print('übergebene chartItems: $chartItems');
//    List convertIntoFLSpots() {
//      List<FlSpot> chartSpots = [];
//      var map = Map();
//      chartItems.forEach((item) {
//        if (!map.containsKey(item.timestamp.toDate().day)) {
//          map[item.timestamp.toDate().day] = 1;
//        } else {
//          map[item.timestamp.toDate().day] += 1;
//        }
//      });
//      List tempList = map.values.toList();
//      for (var i = 0; i < tempList.length; i++) {
//        chartSpots.add(FlSpot(i.toDouble() + 1, tempList[i].toDouble()));
//      }
//      return chartSpots;
//    }
//
//    return LineChartData(
//      gridData: FlGridData(
//        show: true,
//        drawVerticalLine: true,
//        getDrawingHorizontalLine: (value) {
//          return FlLine(
//            color: secondaryGrey,
//            strokeWidth: 1,
//          );
//        },
//        getDrawingVerticalLine: (value) {
//          return FlLine(
//            color: secondaryGrey,
//            strokeWidth: 1,
//          );
//        },
//      ),
//      titlesData: FlTitlesData(
//        show: true,
//        bottomTitles: SideTitles(
//          showTitles: false,
//          reservedSize: 22,
//          textStyle: const TextStyle(
//              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 0:
//                return '';
//              case 1:
//                return 'Mo';
//              case 2:
//                return 'Di';
//              case 3:
//                return 'Mi';
//              case 4:
//                return 'Do';
//              case 5:
//                return 'Fr';
//              case 6:
//                return 'Sa';
//              case 7:
//                return 'So';
//            }
//            return 'Deine Meilensteine die letzten 7 Tage.';
//          },
//          margin: 8,
//        ),
//        leftTitles: SideTitles(
//          showTitles: true,
//          textStyle: const TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontSize: 15,
//          ),
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 1:
//                return '1';
//              case 2:
//                return '2';
//              case 3:
//                return '3';
//              case 4:
//                return '4';
//              case 5:
//                return '5';
//              case 6:
//                return '6';
//              case 7:
//                return '7';
//              case 8:
//                return '8';
//            }
//            return '';
//          },
//          reservedSize: 28,
//          margin: 12,
//        ),
//      ),
//      borderData: FlBorderData(
//          show: true, border: Border.all(color: secondaryGrey, width: 1)),
//      minX: 1,
//      maxX: 7,
//      minY: 0,
//      maxY: 8,
//      lineBarsData: [
//        LineChartBarData(
//          spots: convertIntoFLSpots(),
//          isCurved: true,
//          preventCurveOverShooting: true,
//          colors: gradientColors,
//          barWidth: 5,
//          isStrokeCapRound: true,
//          dotData: FlDotData(
//            show: false,
//          ),
//          belowBarData: BarAreaData(
//            show: true,
//            colors:
//                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//          ),
//        ),
//      ],
//    );
//  }
}
