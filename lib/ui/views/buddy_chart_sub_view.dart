import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_chart_sub_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

// ignore: must_be_immutable
class BuddyChartSubView extends StatelessWidget {
  HabitBuddy habitBuddy;
  BuddyChartSubView({Key key, @required this.habitBuddy}) : super(key: key);
  List<Color> gradientColors = [
    lightPrimaryBlue,
    lightPrimaryBlue,
  ];
  int repetitions = 0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuddyChartSubViewModel>.reactive(
      viewModelBuilder: () => BuddyChartSubViewModel(),
      onModelReady: (model) => model.getBuddyChartItems(habitBuddy),
      builder: (context, model, child) => Stack(
        children: <Widget>[
          ReusableCard(
            color1: primaryBlue,
            color2: primaryBlue,
            cardChild: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Hier kannst Du sehen, wie viele Meilensteine Dein Buddy am Tag erfüllt.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: primaryBlue),
                      child: model.chartItems.length >= 2
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: 30, top: 24, bottom: 10),
                              child: LineChart(
                                mainData(model.chartItems ?? []),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  minimumBuddyMilestones,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                    ),
                  ),
                  model.chartItems.length >= 2
                      ? Row(
                          children: <Widget>[
                            SizedBox(
                              width: 39,
                            ),
                            Text('Die letzten sieben Tage Deines Buddies.',
                                style: TextStyle(color: Colors.white)),
                          ],
                        )
                      : SizedBox(
                          height: 5,
                        ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            left: 10,
            top: 160,
          ),
        ],
      ),
    );
  }

  LineChartData mainData(List chartItems) {
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
              case 9:
                return '9';
              case 10:
                return '10';
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
      maxY: 10,
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
