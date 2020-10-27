import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';

// ignore: must_be_immutable
class UserChart extends StatelessWidget {
  List chartItems;
  var sumEvaluationMap = Map();
  var sumDayCountMap = Map();

  UserChart({Key key, @required this.chartItems}) : super(key: key);
  List<Color> gradientColors = [
    const Color(0xFFC5CAE9),
    const Color(0xFFC5CAE9),
  ];
  int repetitions = 0;
  bool showChart = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
              decoration: const BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.black54,
//                        blurRadius: 5,
//                        offset: Offset(0, 2))
//                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: primaryBlue),
              padding: showChart
                  ? EdgeInsets.only(left: 10, right: 25.0, top: 24, bottom: 30)
                  : EdgeInsets.all(0),
              child: LineChart(
                mainData(),
              )),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(49, 8, 8, 8),
            child: Text('Deine Gewohnheitsstärke der letzten 7 Tage.',
                style: TextStyle(color: Colors.white))),
      ],
    );
  }

  LineChartData mainData() {
    prepareData();
    List convertIntoFLSpots() {
      List<FlSpot> chartSpots = [];
      print(sumEvaluationMap);
      List tempList = sumEvaluationMap.values.toList();
      for (var i = 0; i < tempList.length; i++) {
        chartSpots.add(FlSpot(i.toDouble() + 1, tempList[i].toDouble() * 10));
      }
      if (chartSpots.length == 0) {
        chartSpots.add(FlSpot(0, 0));
        return chartSpots;
      } else {
        return chartSpots;
      }
    }

    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 10,
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
            return 'Deine Gewohnheits-Stärke der letzten 7 Tage.';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0%';
              case 50:
                return '50%';
              case 100:
                return '100%';
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
      maxY: 100,
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

  prepareData() {
    chartItems.forEach((item) {
      if (!sumEvaluationMap.containsKey(item.timestamp.toDate().day)) {
        sumEvaluationMap[item.timestamp.toDate().day] =
            ((item.evaluation + item.evaluation2) / 2);
        sumDayCountMap[item.timestamp.toDate().day] = 1;
      } else {
        sumEvaluationMap[item.timestamp.toDate().day] +=
            ((item.evaluation + item.evaluation2) / 2);
        sumDayCountMap[item.timestamp.toDate().day] += 1;
      }
    });
    sumEvaluationMap.forEach((key, value) {
      sumEvaluationMap[key] = value / sumDayCountMap[key];
    });
  }
}
