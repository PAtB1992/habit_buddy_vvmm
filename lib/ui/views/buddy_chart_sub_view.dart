import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/habit_buddy_info.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_chart_sub_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: must_be_immutable
class BuddyChartSubView extends StatelessWidget {
  HabitBuddyInfo habitBuddyInfo;
  BuddyChartSubView({Key key, @required this.habitBuddyInfo}) : super(key: key);
  List<Color> gradientColors = [
    const Color(0xFFC5CAE9),
    const Color(0xFFC5CAE9),
  ];
  int repetitions = 0;
  bool showChart = true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuddyChartSubViewModel>.reactive(
      viewModelBuilder: () => BuddyChartSubViewModel(),
      onModelReady: (model) => model.getBuddyChartItems(habitBuddyInfo),
      builder: (context, model, child) => Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            ReusableCard(
              color1: Color(0xFF303f9f),
              color2: Color(0xFF3f51b5),
              cardChild: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: primaryBlue),
                  padding: showChart
                      ? EdgeInsets.only(right: 25.0, top: 24, bottom: 30)
                      : EdgeInsets.all(0),
                  child: LineChart(mainData(model.chartItems ?? []))
//                child: model.chartItems.length >= 2
//                    ? LineChart(
//                        mainData(model.chartItems),
//                      )
//                    : Center(
//                        child: Text(
//                          'Dein Buddy muss erst ein paar Meilensteine erledigen, bevor Du seine Statistik sehen kannst.',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        ),
//                      ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 8, 8, 8),
              child: model.chartItems.length >= 2
                  ? Text('Deine letzten sieben Tage.',
                      style: TextStyle(color: Colors.white))
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData(List chartItems) {
    print('übergebene chartItems: $chartItems');
    List convertIntoFLSpots() {
      List<FlSpot> chartSpots = [];
      var map = Map();
      chartItems.forEach((item) {
        if (!map.containsKey(item.timestamp.toDate().day)) {
          map[item.timestamp.toDate().day] = 1;
        } else {
          map[item.timestamp.toDate().day] += 1;
        }
      });
      List tempList = map.values.toList();
      for (var i = 0; i < tempList.length; i++) {
        chartSpots.add(FlSpot(i.toDouble() + 1, tempList[i].toDouble()));
      }
      return chartSpots;
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: secondaryGrey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: secondaryGrey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '';
              case 1:
                return 'Mo';
              case 2:
                return 'Di';
              case 3:
                return 'Mi';
              case 4:
                return 'Do';
              case 5:
                return 'Fr';
              case 6:
                return 'Sa';
              case 7:
                return 'So';
            }
            return 'Deine Meilensteine die letzten 7 Tage.';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
              case 8:
                return '8';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: secondaryGrey, width: 1)),
      minX: 1,
      maxX: 7,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: convertIntoFLSpots(),
          isCurved: true,
          preventCurveOverShooting: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
