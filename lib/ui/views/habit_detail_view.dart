import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/ui/components/user_chart.dart';
import 'package:habitbuddyvvmm/viewmodels/habit_detail_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class HabitDetailView extends StatelessWidget {
  final Habit habit;
  HabitDetailView({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      disposeViewModel: false,
      onModelReady: (model) => model.getChartItems(habit.name),
      viewModelBuilder: () => HabitDetailViewModel(),
      builder: (context, model, child) => Container(
        color: primaryBlue,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                backgroundColor: primaryBlue,
                flexibleSpace: Container(
                  padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                          child: Icon(
                            habit.habitIcon,
                            size: 35.0,
                            color: accentColor,
                          ),
                          backgroundColor: Colors.white,
                          radius: 25.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            habit.customName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ReusableCard(
                        boxShadow: false,
                        center: true,
                        height: 100,
                        color1: primaryBlue,
                        color2: secondaryBlue,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              '${habit.customDescription}',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      ReusableCard(
                        center: true,
                        height: 100,
                        color1: accentColor,
                        color2: accentColorGradient,
                        cardChild: Text(
                          'Trage hier deinen Meilenstein ein',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onPress: () async {
//                      await _navigationService.navigateTo(
//                          MilestoneReflectionViewRoute,
//                          arguments: habit);
                          model.navigateToReflectionViewAndWaitForPop(
                              context, habit);
                          model.getRepetitions(habit.listIndex);
                        },
                      ),
                      ReusableCard(
                        boxShadow: false,
                        height: 200,
                        color1: primaryBlue,
                        color2: secondaryBlue,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'So oft hast Du deinen Meilenstein schon erreicht:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                              //TODO beim Tap Kalender anzeigen (optional!)
                            ),
                            Text(
                              model.repetitions.toString() == null
                                  ? model.getRepetitions
                                  : model.initialRepetitions(habit.listIndex),
                              style:
                                  TextStyle(fontSize: 70, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10),
                          child: UserChart(chartItems: model.chartItems)),
                      ReusableCard(
                        center: true,
                        height: 60,
                        color1: accentColor,
                        color2: accentColorGradient,
                        cardChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Erinnerungen editieren',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            )
                          ],
                        ),
                        onPress: () {
                          print(habit.wasDone);
                          model.navigateToEditReminderView(habit);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
